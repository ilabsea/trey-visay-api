# frozen_string_literal: true

module Spreadsheets
  class Batches::SchoolBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    def import(file)
      return unless valid_zipfile?(file)

      Zip::File.open(file) do |zipfile|
        entry = zipfile.select { |ent| ent.name.split(".").last == excel_format }.first

        return unless entry.present?

        spreadsheet(entry).each_with_pagename do |sheet_name, sheet|
          assign_items(sheet, sheet_name)
        rescue
          Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
        end

        batch.importing_items = importing_items(zipfile)
        batch.attributes = batch.attributes.merge(batch_params(file))
        batch
      end
    end

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
        items = School.where(code: codes)

        @items.map do |row|
          item = items.select { |f| f.code == row["school_code"] }.first || School.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::SchoolSpreadsheet.new(item, @school_majors).process(row, zipfile))
        end
      end

      def spreadsheet(entry)
        ::Zip::IOExtras.copy_stream(stream = StringIO.new, entry.get_input_stream)
        Roo::Spreadsheet.open(stream, extension: excel_format)
      end

      def excel_format
        "xlsx"
      end
  end
end
