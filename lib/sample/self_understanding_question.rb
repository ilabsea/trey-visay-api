# frozen_string_literal: true

require_relative "base"
require_relative "self_understanding_questions/question"
require_relative "self_understanding_questions/option"

module Sample
  class SelfUnderstandingQuestion < Sample::Base
    def import(file="self_understanding_question", options = {})
      spreadsheet(file).each_with_pagename do |sheet_name, sheet|
        sheet_name = sheet_name.to_s.downcase.upcase_first

        rows = sheet.parse(headers: true)
        rows[1..-1].each do |row|
          "::Sample::SelfUnderstandingQuestions::#{sheet_name}".constantize.new.process(row)
        end
      rescue
        Rails.logger.warn "unknown handler for sheet: #{sheet_name}"
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end
  end
end
