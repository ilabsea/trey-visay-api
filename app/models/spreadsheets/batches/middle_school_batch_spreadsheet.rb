# frozen_string_literal: true

module Spreadsheets
  class Batches::MiddleSchoolBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::MiddleSchoolBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse(headers: true)[1..-1] if sheet_name.to_s.downcase == "high_school"
      end

      def importing_items
        codes = @items.map { |r| r["school_code"] }
        items = MiddleSchool.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["school_code"] }.first || MiddleSchool.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::MiddleSchoolSpreadsheet.new(item).process(row))
        end
      end
  end
end
