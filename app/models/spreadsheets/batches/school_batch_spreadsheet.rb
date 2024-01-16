# frozen_string_literal: true

module Spreadsheets
  class Batches::SchoolBatchSpreadsheet < Spreadsheets::Batches::BaseWithZipfileSpreadsheet
    private
      def batch_model
        ::Batches::SchoolBatch
      end

      def assign_items(sheet, sheet_name)
        @items = sheet.parse(headers: true)[1..-1] if sheet_name.to_s.downcase == "school"
        @school_majors = sheet.parse(headers: true)[1..-1] if sheet_name.to_s.downcase == "department_major"
      end

      def importing_items(zipfile)
        codes = @items.map { |r| r["school_code"] }
        items = School.where(code: codes).includes(school_departments: [:department, :majors, school_majors: :major])

        @items.map do |row|
          item = items.select { |f| f.code == row["school_code"] }.first || School.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::SchoolSpreadsheet.new(item, @school_majors).process(row, zipfile))
        end
      end
  end
end
