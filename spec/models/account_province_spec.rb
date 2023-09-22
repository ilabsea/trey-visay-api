# frozen_string_literal: true

# == Schema Information
#
# Table name: account_provinces
#
#  id          :bigint(8)        not null, primary key
#  account_id  :integer
#  province_id :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe AccountProvince, type: :model do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:province).with_foreign_key(:province_id).class_name("Location") }
end
