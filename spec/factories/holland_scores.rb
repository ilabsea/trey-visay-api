# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_scores
#
#  id               :string(255)      not null, primary key
#  holland_quiz_id  :string(255)
#  personality_type :string(255)
#  score            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  display_order    :integer
#
FactoryBot.define do
  factory :holland_score do
  end
end
