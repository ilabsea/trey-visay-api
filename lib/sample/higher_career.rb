# frozen_string_literal: true

require_relative 'base'

module Sample
  class HigherCareer < Sample::Base
    def self.load(file, options = {})
      path = File.expand_path(csv_path + "#{file}.xlsx")
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.each_with_pagename do |_name, sheet|
        sheet.parse.each_with_index do |row, index|
          code = row[0]
          name = row[1]
          short_description = row[3]
          duty = row[4]
          working_environment = row[5]
          training_level = row[6]
          salary = row[7]

          # @Todo: change by by id to find by code
          career = ::Career.find_or_initialize_by(name: name)
          career.update_attributes(
            short_description: short_description,
            duty: duty,
            working_environment: working_environment,
            training_level: training_level,
            salary: salary
          )
        end
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end
  end
end
