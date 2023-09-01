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
          code: format_code(row[0]),
          name_km: row[1],
          name_en: row[2],
          personality_type: [row[3], row[4], row[5]].join,
          general_description: row[6],
          jd_main_task: row[7],
          jd_environment: row[8],
          jd_work_style: row[9],
          edu_education_level: row[10],
          edu_subjects_at_high_school: row[11],
          edu_majors_at_university: row[12],
          personal_competency_knowledge: row[13],
          personal_competency_skill: row[14],
          personal_competency_ability: row[15],
          logo: find_attachment(row[17], zipfile)
        }

        job.job_cluster = JobCluster.find_by(code: row[16]) if row[16].present?
        job
      end
    end
  end
end
