# frozen_string_literal: true

module Spreadsheets
  class Batches::MajorBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::MajorBatch
      end

      def assign_items(sheet, sheet_name)
        @items += sheet.parse[1..-1]
      end

      def importing_items
        codes = @items.map { |r| r[0].to_s.strip }
        names = @items.map { |r| r[1].to_s.strip }
        items = Major.where("code in (?) OR name in (?)", codes, names).uniq

        @items.map do |row|
          item = items.select { |f| f.code == row[0].to_s.strip || f.name == row[1].to_s.strip }.first || Major.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::MajorSpreadsheet.new(item).process(row))
        end
      end
  end
end
