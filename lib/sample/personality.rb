# frozen_string_literal: true

require_relative "base"

module Sample
  class Personality < Sample::Base
    def self.load(file, options = {})
      path = File.expand_path(csv_path + "#{file}.xlsx")
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.each_with_pagename do |sheet_name, sheet|
        sheet.parse.each do |row|
          code = row[0]
          name_km = row[1]
          category = sheet_name.downcase

          personality = ::Personality.find_or_initialize_by(code: code)
          personality.update_attributes(name_km: name_km, category: category)
        end
      end

      puts "Loaded #{file.titleize} samples" if options[:verbose]
    end

    def self.export
      data = []
      ::Personality.find_each do |record|
        obj = {
          code: record.code,
          name_km: record.name_km,
          name_en: record.name_en,
          category: record.category
        }

        data.push(obj)
      end

      write_to_file(data, "personality")
    end
  end
end
