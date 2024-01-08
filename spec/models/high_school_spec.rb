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
require "rails_helper"

RSpec.describe HighSchool, type: :model do
  it { is_expected.to validate_presence_of(:name_km) }
  it { is_expected.to validate_presence_of(:district_id) }
end
