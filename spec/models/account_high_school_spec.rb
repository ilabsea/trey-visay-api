# frozen_string_literal: true

# == Schema Information
#
# Table name: account_high_schools
#
#  id             :bigint(8)        not null, primary key
#  high_school_id :string(255)
#  account_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  province_id    :string(255)
#  district_id    :string(255)
#
require "rails_helper"

RSpec.describe AccountHighSchool, type: :model do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:high_school).optional }
  it { is_expected.to belong_to(:province).with_foreign_key(:province_id).class_name("Location").optional }
end
