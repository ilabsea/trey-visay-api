# frozen_string_literal: true

require "sample"

namespace :university do
  desc "add value code to university"
  task migrate_code: :environment do
    csv_path = Pathname.new(File.join(Dir.pwd, "db", "csv"))

    path = File.expand_path(csv_path + "id_to_code_university.xlsx")
    xlsx = Roo::Spreadsheet.open(path)

    xlsx.each_with_pagename do |_name, sheet|
      sheet.parse.each_with_index do |row, _index|
        next if row[0].nil?
        code = row[2]
        id = row[1].to_i
        school = School.find(id)
        school.code = code
        school.save!
      end
    end
  end

  desc "create or update university"
  task load: :environment do
    Sample::University.load("university")
  end
end
