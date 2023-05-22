# frozen_string_literal: true

module Spreadsheets
  class HollandQuestionBatchSpreadsheet < BaseSpreadsheet
    attr_reader :batch

    def initialize
      @batch = HollandQuestionBatch.new
      @holland_questions = []
    end

    def import(file)
      return unless valid?(file)

      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        rows = sheet.parse(headers: true)
        @holland_questions.concat rows[1..-1]
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      batch.importing_holland_questions = importing_holland_questions
      batch.attributes = batch.attributes.merge(batch_params(file))
      batch
    end

    private
      def batch_params(file)
        holland_questions = batch.importing_holland_questions.map(&:holland_question)
        {
          total_count: holland_questions.length,
          valid_count: holland_questions.select(&:valid?).length,
          new_count: holland_questions.select(&:new_record?).length,
          reference: file
        }
      end

      def importing_holland_questions
        codes = @holland_questions.map { |r| r["code"] }
        holland_questions = HollandQuestion.where(code: codes)

        @holland_questions.map do |row|
          holland_question = holland_questions.select { |f| f.code == row["code"] }.first || HollandQuestion.new
          batch.importing_holland_questions.new(holland_question: Spreadsheets::HollandQuestionBatches::HollandQuestionSpreadsheet.new(holland_question).process(row))
        end
      end
  end
end
