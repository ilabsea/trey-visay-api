# frozen_string_literal: true

# == Schema Information
#
# Table name: major_personality_types
#
#  id                  :bigint(8)        not null, primary key
#  major_id            :string(255)
#  personality_type_id :string(255)
#  display_order       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :major_personality_type do
  end
end
