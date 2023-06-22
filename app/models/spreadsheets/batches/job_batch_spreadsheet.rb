# frozen_string_literal: true

module Spreadsheets
  class Batches::JobBatchSpreadsheet < Spreadsheets::Batches::BaseWithZipfileSpreadsheet
    private
      def batch_model
        ::Batches::JobBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse[1..-1] if sheet_name == "jobs"
      end

      def importing_items(zipfile)
        codes = @items.map { |r| r[0] }
        items = Job.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row[0] }.first || Job.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::JobSpreadsheet.new(item).process(row, zipfile))
        end
      end
  end
end
