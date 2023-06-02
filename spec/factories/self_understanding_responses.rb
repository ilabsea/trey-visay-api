# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_responses
#
#  id                               :string(255)      not null, primary key
#  holland_quiz_id                  :string(255)
#  self_understanding_question_id   :string(255)
#  self_understanding_question_code :string(255)
#  value                            :string(255)
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
FactoryBot.define do
  factory :self_understanding_response do
  end
end
