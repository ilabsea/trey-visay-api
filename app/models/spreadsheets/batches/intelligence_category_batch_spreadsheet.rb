# frozen_string_literal: true

module Spreadsheets
  class Batches::IntelligenceCategoryBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::IntelligenceCategoryBatch
      end

      def importing_items
        codes = @items.map { |r| r["code"] }
        items = IntelligenceCategory.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["code"] }.first || IntelligenceCategory.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::IntelligenceCategorySpreadsheet.new(item).process(row))
        end
      end
  end
end
