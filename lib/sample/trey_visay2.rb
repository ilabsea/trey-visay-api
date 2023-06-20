# frozen_string_literal: true
require_relative "execute"
require_relative "self_understanding_question"

module Sample
  class TreyVisay2
    def load_sample
      Sample::Execute.load("accounts", {})
      Sample::SelfUnderstandingQuestion.new.import

      create_batch("HollandQuestionBatch", "holland_question.xlsx")
      create_batch("SchoolBatch", "schools.zip")
      create_batch("MiddleSchoolBatch", "middle_school.xlsx")
      create_batch("VideoBatch", "video.xlsx")
      create_batch("JobClusterBatch", "job_cluster.xlsx")
      create_batch("JobBatch", "job.xlsx")
      create_batch("CollegeMajorBatch", "college_major.xlsx")
    end

    private
      def create_batch(model_name, filename)
        klass = "::Spreadsheets::Batches::#{model_name}Spreadsheet".constantize
        batch = klass.new.import(file(filename))
        batch.creator = creator
        batch.save

        puts "Loaded #{model_name} samples"
      rescue
        Rails.logger.warn "unknown handler for class: #{klass}"
      end

      def file(filename)
        File.open(Pathname.new(File.join(Rails.root, "public", "sample", filename)))
      end

      def creator
        @creator ||= Account.first
      end
  end
end
