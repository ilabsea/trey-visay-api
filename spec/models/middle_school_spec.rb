# frozen_string_literal: true

# == Schema Information
#
# Table name: middle_schools
#
#  id          :string(8)        not null, primary key
#  code        :string(255)
#  name        :string(255)
#  province_id :string(255)
#  district_id :string(255)
#  commune_id  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe MiddleSchool, type: :model do
  it { is_expected.to have_many(:importing_items) }
  it { is_expected.to have_many(:batches).through(:importing_items) }
end
