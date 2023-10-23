# frozen_string_literal: true

module Spreadsheets
  module Batches
    class PersonalityTypeSpreadsheet
      attr_reader :personality_type

      def initialize(personality_type)
        @personality_type = personality_type
      end

      def process(row)
        personality_type.attributes = {
          code: row["code"],
          name_km: row["name_km"],
          name_en: row["name_en"],
          description: row["description"],
          recommendation: row["recommendation"],
          personal_value: row["personal_value"],
          skill_and_ability: row["skill_and_ability"]
        }
        personality_type
      end
    end
  end
end
