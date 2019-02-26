# frozen_string_literal: true

require_relative 'base'

module Sample
  class HighSchool < Sample::Base
    def self.load(file, options = {})
      path = File.expand_path(csv_path + "#{file}.xlsx")
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.each_with_pagename do |name, sheet|
        sheet.parse.each_with_index do |row, index|
          next if index == 0

          name_km = row[2]
          location_code = row[3]
          code = row[4]

          school = ::HighSchool.find_or_initialize_by(code: code)
          school.update_attributes(name_km: name_km, location_code: location_code)
        end
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end

    def self.export
      schools = []
      ::HighSchool.find_each do |school|
        skool = {
          code: school.code,
          label: school.name_km,
          name_en: school.name_en,
          parent_code: school.location_code
        }

        schools.push(skool)
      end

      write_to_file(schools, 'highSchools')
    end
  end
end
