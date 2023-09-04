# frozen_string_literal: true

module Spreadsheets
  module Batches
    class MajorSpreadsheet
      attr_reader :major

      def initialize(major)
        @major = major
      end

      def process(row)
        major.attributes = {
          code: row[0].to_s.strip,
          name: row[1].to_s.strip,
          parent_code: row[2],
          personality_type: [row[3], row[4], row[5]].join,
          general_info: row[6],
          orien_orientation_subjects: row[7],
          orien_study_condition: row[8],
          orien_graduation_condition: row[9],
          curriculum: row[10],
          teaching_and_learning_process: row[11],
          gain_knowledge: row[12],
          worthy_career: row[13],
          recommendation: row[14]
        }

        major
      end
    end
  end
end
