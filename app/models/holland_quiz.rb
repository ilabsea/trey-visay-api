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
class HollandQuiz < Quiz
  # Constant
  SELF_UNDERSTANDING_PASS_SCORE = 4

  # Association
  belongs_to :user, counter_cache: true
  has_many :self_understanding_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_major_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_job_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_scores, inverse_of: :quiz

  # Nested attributes
  include HollandQuizzes::NestedAttributeConcern

  # Callback
  after_save :update_user_supporting_dashboard

  private
    def update_user_supporting_dashboard
      user.update(
        is_complete_grade_twelve: self_understanding_responses.where(self_understanding_question_code: %w(q1 q2), value: "unsure").blank?,
        is_self_understanding: self_understanding_score.to_i >= SELF_UNDERSTANDING_PASS_SCORE,
        is_selected_major_or_career: (holland_major_response_ids.present? || holland_job_response_ids.present?)
      )
    end
end
