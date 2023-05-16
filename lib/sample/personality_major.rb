# frozen_string_literal: true

require_relative "base"

module Sample
  class PersonalityMajor < Sample::Base
    def self.load(file, options = {})
      path = File.expand_path(csv_path + "#{file}.xlsx")
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.each_with_pagename do |_sheet_name, sheet|
        sheet.parse.each do |row|
          code = row[0]
          name_en = row[1]
          name_km = row[2]
          basic_knowledge = row[3]
          study_credit = row[4]
          recieved_knowledge = strip_str(row[5])
          possible_workplaces = strip_str(row[6])

          next if name_km.blank?

          major = ::PersonalityMajor.find_or_initialize_by(code:)
          major.update_attributes(
            name_en:,
            name_km:,
            basic_knowledge:,
            study_credit:,
            recieved_knowledge:,
            possible_workplaces:
          )
        end
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end

    def self.export
      data = []
      ::PersonalityMajor.find_each do |record|
        obj = {
          code: record.code,
          name_en: record.name_en,
          name_km: record.name_km,
          basic_knowledge: record.basic_knowledge,
          study_credit: record.study_credit,
          recieved_knowledge: record.recieved_knowledge,
          possible_workplaces: record.possible_workplaces
        }

        data.push(obj)
      end

      write_to_file(data, "personality_major")
    end
  end
end
