# frozen_string_literal: true

module Spreadsheets
  module Batches
    class CollegeMajorSpreadsheet
      attr_reader :major

      def initialize(major)
        @major = major
      end

      def process(row)
        major.attributes = {
          code: row[0],
          name: row[1],
          personality_type: row[2],
          general_info: row[4],
          orien_orientation_subjects: row[5],
          orien_study_condition: row[6],
          orien_graduation_condition: row[7],
          curriculum: row[8],
          teaching_and_learning_process: row[9],
          gain_knowledge: row[10],
          worthy_career: row[11],
          recommendation: row[12]
        }

        major
      end
    end
  end
end
