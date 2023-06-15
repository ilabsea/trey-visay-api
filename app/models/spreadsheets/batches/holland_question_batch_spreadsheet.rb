# frozen_string_literal: true

module Spreadsheets
  class Batches::HollandQuestionBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::HollandQuestionBatch
      end

      def importing_items
        codes = @items.map { |r| r["code"] }
        items = HollandQuestion.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["code"] }.first || HollandQuestion.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::HollandQuestionSpreadsheet.new(item).process(row))
        end
      end
  end
end
