# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_responses
#
#  id                         :string(255)      not null, primary key
#  intelligence_quiz_id       :string(255)
#  intelligence_question_id   :string(255)
#  intelligence_question_code :string(255)
#  value                      :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
FactoryBot.define do
  factory :intelligence_response do
  end
end
