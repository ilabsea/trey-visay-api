# frozen_string_literal: true

module Spreadsheets
  class Batches::JobClusterBatchSpreadsheet < Spreadsheets::Batches::BaseWithZipfileSpreadsheet
    private
      def batch_model
        ::Batches::JobClusterBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse(headers: true)[1..-1]
      end

      def importing_items(zipfile)
        codes = @items.map { |r| r["code"] }
        items = JobCluster.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["code"] }.first || JobCluster.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::JobClusterSpreadsheet.new(item).process(row, zipfile))
        end
      end
  end
end
