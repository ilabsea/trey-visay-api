# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id          :string(255)      not null, primary key
#  user_id     :integer
#  quizzed_at  :datetime
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  finished_at :datetime
#
class HollandQuiz < Quiz
  # Association
  has_many :self_understanding_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_major_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_job_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_scores, inverse_of: :quiz

  # Nested attributes
  include HollandQuizzes::NestedAttributeConcern
end
