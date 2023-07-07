# frozen_string_literal: true

module Spreadsheets
  class Batches::IntelligenceQuestionBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::IntelligenceQuestionBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse(headers: true)[1..-1] if sheet_name.downcase == "question"
      end

      def importing_items
        codes = @items.map { |r| r["code"] }
        items = IntelligenceQuestion.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["code"] }.first || IntelligenceQuestion.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::IntelligenceQuestionSpreadsheet.new(item).process(row))
        end
      end
  end
end
