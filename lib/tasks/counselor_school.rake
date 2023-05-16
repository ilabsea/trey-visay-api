# frozen_string_literal: true

namespace :counselor_school do
  desc "seed data"
  task seed_data: :environment do
    csv = File.read(File.join(Rails.root, "public", "school.csv"))
    rows = CSV.parse(csv, headers: true)
    rows.each do |row|
      CounselorSchool.find_or_create_by name: row[1]
    end
  end
end
