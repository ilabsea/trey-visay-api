# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_quizzes
#
#  id                        :string(255)      not null, primary key
#  user_id                   :integer
#  personality_type_results  :string(255)
#  college_major_id          :string(255)
#  job_id                    :string(255)
#  quizzed_at                :datetime
#  selected_college_major_at :datetime
#  selected_job_at           :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class HollandQuiz < ApplicationRecord
  # Association
  belongs_to :user

  has_many :self_understanding_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_major_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_job_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_scores, inverse_of: :quiz

  # Nested attributes
  include HollandQuizzes::NestedAttributeConcern

  # Serialize
  serialize :personality_type_results, Array

  # Callback
  before_create :secure_id

  # Scope
  default_scope { order(quizzed_at: :asc) }
end
