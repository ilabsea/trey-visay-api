# frozen_string_literal: true

module Spreadsheets
  class SchoolBatchSpreadsheet < BaseSpreadsheet
    attr_reader :account, :batch

    def initialize(account)
      @account = account
      @batch = SchoolBatch.new
      @schools = []
      @school_majors = []
    end

    def import(file)
      return unless valid?(file)

      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        rows = sheet.parse(headers: true)
        sheet_name = sheet_name.to_s.downcase

        @schools = rows[1..-1] if sheet_name == "school"
        @school_majors = rows[1..-1] if sheet_name == "department_major"
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      batch.importing_schools = importing_schools
      batch.attributes = batch.attributes.merge(batch_params(file))
      batch
    end

    private
      def batch_params(file)
        schools = batch.importing_schools.map(&:school)
        {
          total_count: schools.length,
          valid_count: schools.select(&:valid?).length,
          new_count: schools.select(&:new_record?).length,
          reference: file
        }
      end

      def importing_schools
        codes = @schools.map { |r| r["school_code"] }
        schools = School.where(code: codes)

        @schools.map do |row|
          school = schools.select { |f| f.code == row["school_code"] }.first || School.new

          batch.importing_schools.new(school: Spreadsheets::SchoolBatches::SchoolSpreadsheet.new(school, @school_majors).process(row))
        end
      end
  end
end
