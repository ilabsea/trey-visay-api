# frozen_string_literal: true

module Spreadsheets
  module Batches
    class JobSpreadsheet
      include ::Spreadsheets::AttachmentSpreadsheet

      attr_reader :job

      def initialize(job)
        @job = job
      end

      def process(row, zipfile)
        job.attributes = {
          code: row[0],
          name_km: row[1],
          name_en: row[2],
          personality_type: row[3],
          general_description: row[4],
          jd_main_task: row[5],
          jd_environment: row[6],
          jd_technology_skill: row[7],
          edu_education_level: row[8],
          edu_high_school_supported_subject: row[9],
          edu_higher_education_skill: row[10],
          qua_supported_knowledge: row[11],
          qua_supported_skill: row[12],
          qua_supported_capacity: row[13],
          qua_characteristic_of_job: row[14],
          info_job_market: row[15],
          info_similar_job: row[16],
          logo: find_attachment(row[18], zipfile),
          job_majors_attributes: job_majors_attributes(row[10])
        }

        job.job_cluster = JobCluster.find_by(code: row[17]) if row[17].present?
        job
      end

      private
        def job_majors_attributes(edu_higher_education_skill)
          return [] unless edu_higher_education_skill.present?

          major_names = edu_higher_education_skill.split(" ")
          major_names.map do |name|
            { major_attributes: { name: name } }
          end
        end
    end
  end
end
