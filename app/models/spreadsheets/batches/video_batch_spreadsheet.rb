# frozen_string_literal: true

module Spreadsheets
  class Batches::VideoBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::VideoBatch
      end

      def importing_items
        codes = @items.map { |r| r["code"] }
        items = Video.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["code"] }.first || Video.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::VideoSpreadsheet.new(item).process(row))
        end
      end
  end
end
