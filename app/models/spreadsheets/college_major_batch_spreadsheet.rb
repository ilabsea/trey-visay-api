# frozen_string_literal: true

module Spreadsheets
  class CollegeMajorBatchSpreadsheet < BaseSpreadsheet
    attr_reader :batch

    def initialize
      @batch = CollegeMajorBatch.new
      @majors = []
    end

    def import(file)
      return unless valid?(file)

      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        rows = sheet.parse
        @majors = rows[1..-1]
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      batch.importing_college_majors = importing_college_majors
      batch.attributes = batch.attributes.merge(batch_params(file))
      batch
    end

    private
      def batch_params(file)
        majors = batch.importing_college_majors.map(&:college_major)
        {
          total_count: majors.length,
          valid_count: majors.select(&:valid?).length,
          new_count: majors.select(&:new_record?).length,
          reference: file
        }
      end

      def importing_college_majors
        codes = @majors.map { |r| r[0] }
        majors = CollegeMajor.where(code: codes)

        @majors.map do |row|
          major = majors.select { |f| f.code == row[0] }.first || CollegeMajor.new
          batch.importing_college_majors.new(college_major: Spreadsheets::CollegeMajorBatches::CollegeMajorSpreadsheet.new(major).process(row))
        end
      end
  end
end
