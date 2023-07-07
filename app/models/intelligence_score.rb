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
class IntelligenceScore < ApplicationRecord
  # Association
  belongs_to :quiz, class_name: :IntelligenceQuiz, foreign_key: :intelligence_quiz_id
  belongs_to :intelligence_category

  # Callback
  before_create :secure_id

  # Scope
  default_scope { order(score: :desc) }

  # Delegation
  delegate :name, to: :intelligence_category, prefix: true
end
