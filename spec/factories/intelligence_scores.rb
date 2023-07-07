# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_scores
#
#  id                       :string(255)      not null, primary key
#  intelligence_quiz_id     :string(255)
#  intelligence_category_id :string(255)
#  score                    :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
FactoryBot.define do
  factory :intelligence_score do
  end
end
