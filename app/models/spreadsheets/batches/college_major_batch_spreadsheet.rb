# frozen_string_literal: true

module Spreadsheets
  class Batches::CollegeMajorBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::CollegeMajorBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse[1..-1]
      end

      def importing_items
        codes = @items.map { |r| r[0] }
        items = CollegeMajor.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row[0] }.first || CollegeMajor.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::CollegeMajorSpreadsheet.new(item).process(row))
        end
      end
  end
end
