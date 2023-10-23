# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_types
#
#  id                :string(255)      not null, primary key
#  code              :string(255)
#  name_km           :string(255)
#  name_en           :string(255)
#  recommendation    :text(65535)
#  description       :text(65535)
#  personal_value    :text(65535)
#  skill_and_ability :text(65535)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :personality_type do
    code { %w(R A I C S E).sample }
    name_km { FFaker::Name.name }
    name_en { FFaker::Name.name }
    description { FFaker::Name.name }
    personal_value { FFaker::Name.name }
    skill_and_ability { FFaker::Name.name }
    recommendation { FFaker::Name.name }
  end
end
