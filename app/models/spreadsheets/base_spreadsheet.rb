# frozen_string_literal: true

class Spreadsheets::BaseSpreadsheet
  def import(file)
    return unless valid?(file)

    spreadsheet(file).each_with_pagename do |sheet_name, sheet|
      rows = sheet.parse(headers: true)
      rows[1..-1].each do |row|
        process(row)
      end
    rescue
      Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
    end
  end

  private
    def spreadsheet(file)
      Roo::Spreadsheet.open(file)
    end

    def valid?(file)
      file.present? && accepted_formats.include?(File.extname(file.path))
    end

    def accepted_formats
      [".xlsx"]
    end

    def parse_string(data)
      data.to_s.strip
    end

    def parse_date(date)
      DateTime.parse(parse_string(date)) rescue nil
    end
end
