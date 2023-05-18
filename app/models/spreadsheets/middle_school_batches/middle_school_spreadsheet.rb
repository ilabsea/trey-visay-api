# frozen_string_literal: true

module Spreadsheets
  module MiddleSchoolBatches
    class MiddleSchoolSpreadsheet
      attr_reader :school

      def initialize(school)
        @school = school
      end

      def process(row)
        commune = Pumi::Commune.find_by_id(row["commune_id"])

        school.attributes = {
          code: row["school_code"],
          name: row["school_name"],
          commune_id: row["commune_id"],
          district_id: commune.try(:district_id),
          province_id: commune.try(:province_id)
        }

        school
      end
    end
  end
end
