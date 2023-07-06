# frozen_string_literal: true

module Spreadsheets
  module Batches
    class IntelligenceCategorySpreadsheet
      attr_reader :category

      def initialize(category)
        @category = category
      end

      def process(row)
        category.attributes = {
          code: row["code"],
          name_km: row["name_km"],
          name_en: row["name_en"],
          description: row["description"],
          appropriate_learning_method: row["appropriate_learning_method"],
          suitable_job: row["suitable_job"]
        }

        category
      end
    end
  end
end
