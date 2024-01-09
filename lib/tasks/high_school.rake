# frozen_string_literal: true

namespace :high_school do
  desc "Migrate province_id"
  task migrate_province_id: :environment do
    schools = HighSchool.where.not(district_id: nil)
    schools.each do |school|
      school.update(province_id: school.district_id[0..1])
    end
  end

  desc "Add school with code 'other'"
  task migrate_high_school_other: :environment do
    school = HighSchool.find_or_initialize_by(name_km: "ផ្សេងៗ")
    school.update(code: "other", district_id: "0000", province_id: "00")
  end

  desc "Migrate school version to v2"
  task migrate_high_school_version: :environment do
    high_schools = HighSchool.where("LENGTH(code) >= ?", 9).or(HighSchool.where(code: "other"))
    high_schools.update_all(version: 2)
    high_schools.touch_all
  end
end
