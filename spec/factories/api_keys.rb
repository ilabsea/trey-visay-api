# frozen_string_literal: true

# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint(8)        not null, primary key
#  access_token :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :api_key do
    access_token { "MyString" }
  end
end
