# frozen_string_literal: true

require_relative "base"

module Sample
  class PersonalityCategory < Sample::Base
    def self.load(file, options = {})
      path = File.expand_path(csv_path + "#{file}.xlsx")
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.each_with_pagename do |_sheet_name, sheet|
        sheet.parse.each do |row|
          code = row[0]
          name_en = row[1]
          name_km = row[2]
          description = strip_str(row[3])
          group = row[4].downcase
          major_codes = strip_str(row[5]).split(";")
          majors = ::PersonalityMajor.where(code: major_codes)
          career_codes = strip_str(row[7]).split(";")
          careers = ::Career.where(code: career_codes)

          category = ::PersonalityCategory.find_or_initialize_by(code:)
          category.update_attributes(name_en:, name_km:, group:, description:)
          category.personality_majors = majors
          category.careers = careers
        end
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end

    def self.export
      data = []
      ::PersonalityCategory.find_each do |record|
        obj = {
          code: record.code,
          name_en: record.name_en,
          name_km: record.name_km,
          group: record.group,
          description: record.description,
          majors: record.personality_majors.pluck(:code),
          careers: record.careers.pluck(:code)
        }

        data.push(obj)
      end

      write_to_file(data, "personality_category")
    end
  end
end
