# frozen_string_literal: true

module Spreadsheets
  class JobBatchSpreadsheet < BaseSpreadsheet
    attr_reader :batch

    def initialize
      @batch = JobBatch.new
      @jobs = []
    end

    def import(file)
      return unless valid?(file)

      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        next unless sheet_name.to_s.downcase == "career_list"

        rows = sheet.parse
        @jobs = rows[1..-1]
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      batch.importing_jobs = importing_jobs
      batch.attributes = batch.attributes.merge(batch_params(file))
      batch
    end

    private
      def batch_params(file)
        jobs = batch.importing_jobs.map(&:job)
        {
          total_count: jobs.length,
          valid_count: jobs.select(&:valid?).length,
          new_count: jobs.select(&:new_record?).length,
          reference: file
        }
      end

      def importing_jobs
        codes = @jobs.map { |r| r[0] }
        jobs = Job.where(code: codes)

        @jobs.map do |row|
          job = jobs.select { |f| f.code == row[0] }.first || Job.new
          batch.importing_jobs.new(job: Spreadsheets::JobBatches::JobSpreadsheet.new(job).process(row))
        end
      end
  end
end
