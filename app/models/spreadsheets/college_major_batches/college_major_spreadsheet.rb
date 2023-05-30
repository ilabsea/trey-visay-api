# frozen_string_literal: true

module Spreadsheets
  module CollegeMajorBatches
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
          general_info: row[3],
          orien_orientation_subjects: row[4],
          orien_study_condition: row[5],
          orien_graduation_condition: row[6],
          curriculum: row[7],
          teaching_and_learning_process: row[8],
          gain_knowledge: row[9],
          worthy_career: row[10],
          recommendation: row[11],
        }

        major
      end
    end
  end
end
