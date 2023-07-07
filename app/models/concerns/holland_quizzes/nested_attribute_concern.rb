# frozen_string_literal: true

module HollandQuizzes::NestedAttributeConcern
  extend ActiveSupport::Concern

  included do
    accepts_nested_attributes_for :holland_scores

    def self_understanding_responses_attributes=(attributes)
      attributes.each do |attribute|
        attribute[:self_understanding_question_id] ||= SelfUnderstandingQuestion.find_by(code: attribute[:self_understanding_question_code]).try(:id)

        self.self_understanding_responses.new(attribute)
      end
    end

    def holland_responses_attributes=(attributes)
      attributes.each do |attribute|
        attribute[:holland_question_id] ||= HollandQuestion.find_by(code: attribute[:holland_question_code]).try(:id)

        self.holland_responses.new(attribute)
      end
    end

    def holland_major_responses_attributes=(attributes)
      attributes.each do |attribute|
        attribute[:college_major_id] ||= CollegeMajor.find_by(code: attribute[:college_major_code]).try(:id)

        self.holland_major_responses.new(attribute.slice(:college_major_id, :selected))
      end
    end

    def holland_job_responses_attributes=(attributes)
      attributes.each do |attribute|
        attribute[:job_id] ||= Job.find_by(code: attribute[:job_code]).try(:id)

        self.holland_job_responses.new(attribute.slice(:job_id, :selected))
      end
    end
  end
end
