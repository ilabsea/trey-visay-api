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
#
class HollandScore < ApplicationRecord
  PERSONALITY_TYPES = %w(R I A S E C)

  # Association
  belongs_to :quiz, class_name: :HollandQuiz, foreign_key: :holland_quiz_id

  # Callback
  before_create :secure_id

  # Validation
  validates :personality_type, presence: true, inclusion: { in: PERSONALITY_TYPES }

  # Scope
  default_scope { order(score: :desc) }
end
