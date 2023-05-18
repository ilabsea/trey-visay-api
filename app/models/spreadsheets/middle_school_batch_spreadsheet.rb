# frozen_string_literal: true

module Spreadsheets
  class MiddleSchoolBatchSpreadsheet < BaseSpreadsheet
    attr_reader :batch

    def initialize
      @batch = MiddleSchoolBatch.new
      @schools = []
    end

    def import(file)
      return unless valid?(file)

      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        next unless sheet_name.to_s.downcase == "high_school"

        rows = sheet.parse(headers: true)
        @schools = rows[1..-1]
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      batch.importing_middle_schools = importing_middle_schools
      batch.attributes = batch.attributes.merge(batch_params(file))
      batch
    end

    private
      def batch_params(file)
        schools = batch.importing_middle_schools.map(&:middle_school)
        {
          total_count: schools.length,
          valid_count: schools.select(&:valid?).length,
          new_count: schools.select(&:new_record?).length,
          province_count: schools.pluck(:province_id).compact.uniq.length,
          reference: file
        }
      end

      def importing_middle_schools
        codes = @schools.map { |r| r["school_code"] }
        schools = MiddleSchool.where(code: codes)

        @schools.map do |row|
          school = schools.select { |f| f.code == row["school_code"] }.first || MiddleSchool.new
          batch.importing_middle_schools.new(middle_school: Spreadsheets::MiddleSchoolBatches::MiddleSchoolSpreadsheet.new(school).process(row))
        end
      end
  end
end
