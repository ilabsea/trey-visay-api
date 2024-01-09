# frozen_string_literal: true

# == Schema Information
#
# Table name: high_schools
#
#  code        :string(10)       not null, primary key
#  name_km     :string(255)
#  name_en     :string(255)
#  district_id :string(255)
#  province_id :string(255)
#  commune_id  :string(255)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  version     :integer          default(1)
#
# Indexes
#
#  index_high_schools_on_code  (code) UNIQUE
#
FactoryBot.define do
  factory :high_school do
    name_km       { FFaker::Name.name }
    name_en       { FFaker::Name.name }
    district_id   { Pumi::District.all.sample.id }
  end
end
