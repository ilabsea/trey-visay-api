# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_major_responses
#
#  id              :string(255)      not null, primary key
#  holland_quiz_id :string(255)
#  selected        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  major_id        :integer
#
FactoryBot.define do
  factory :holland_major_response do
  end
end
