# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id                       :string(255)      not null, primary key
#  user_id                  :integer
#  quizzed_at               :datetime
#  type                     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  finished_at              :datetime
#  self_understanding_score :integer
#
class IntelligenceQuiz < Quiz
  # Association
  belongs_to :user, counter_cache: true
  has_many :intelligence_responses, inverse_of: :quiz, dependent: :destroy
  has_many :intelligence_scores, inverse_of: :quiz, dependent: :destroy

  # Nested attributes
  include IntelligenceQuizzes::NestedAttributeConcern
end
