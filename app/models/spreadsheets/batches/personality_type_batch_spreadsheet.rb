# frozen_string_literal: true

module Spreadsheets
  class Batches::PersonalityTypeBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::PersonalityTypeBatch
      end

      def importing_items
        codes = @items.map { |r| r["code"] }
        items = PersonalityType.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["code"] }.first || PersonalityType.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::PersonalityTypeSpreadsheet.new(item).process(row))
        end
      end
  end
end
