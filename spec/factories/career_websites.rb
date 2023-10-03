# frozen_string_literal: true

# == Schema Information
#
# Table name: career_websites
#
#  id          :string(255)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  logo        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#
FactoryBot.define do
  factory :career_website do
    name { FFaker::Name.name }
    url  { FFaker::Internet.http_url }
  end
end
