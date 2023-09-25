# frozen_string_literal: true

module Spreadsheets
  class Batches::CareerWebsiteBatchSpreadsheet < Spreadsheets::Batches::BaseWithZipfileSpreadsheet
    private
      def batch_model
        ::Batches::CareerWebsiteBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse(headers: true)[1..-1]
      end

      def importing_items(zipfile)
        items = CareerWebsite.where(id: @items.map { |r| r["id"] })

        @items.map do |row|
          item = items.select { |f| f.id == row["id"] }.first || CareerWebsite.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::CareerWebsiteSpreadsheet.new(item).process(row, zipfile))
        end
      end
  end
end
