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
FactoryBot.define do
  factory :account_province do
  end
end
