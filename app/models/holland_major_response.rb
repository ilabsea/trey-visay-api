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
class HollandMajorResponse < ApplicationRecord
  # Association
  belongs_to :quiz, class_name: :HollandQuiz, foreign_key: :holland_quiz_id
  belongs_to :major

  # Callback
  before_create :secure_id

  # Scope
  scope :selected, -> { where(selected: true) }

  # Delegation
  delegate :name, to: :college_major, prefix: :college_major
end
