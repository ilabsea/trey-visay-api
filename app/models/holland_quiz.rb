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
#  display_order            :integer
#
class HollandQuiz < Quiz
  # Constant
  SELF_UNDERSTANDING_PASS_SCORE = 4

  # Association
  belongs_to :user, counter_cache: true
  has_many :self_understanding_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_responses, inverse_of: :quiz, dependent: :destroy
  has_many :holland_major_responses, inverse_of: :quiz, dependent: :destroy, foreign_key: :holland_quiz_id
  has_many :holland_job_responses, inverse_of: :quiz, dependent: :destroy, foreign_key: :holland_quiz_id
  has_many :holland_scores, inverse_of: :quiz, foreign_key: :holland_quiz_id

  # Nested attributes
  include HollandQuizzes::NestedAttributeConcern

  # Callback
  before_create :set_display_order
  after_create :update_user_supporting_dashboard

  private
    # Update to user for only first test
    def update_user_supporting_dashboard
      attributes = {}
      attributes[:is_selected_major_or_career] = (holland_major_response_ids.present? || holland_job_response_ids.present?) if user.is_selected_major_or_career.nil?
      attributes[:potential_drop_off] = self_understanding_responses.where(self_understanding_question_code: %w(q1 q2), value: "unsure").present? if user.potential_drop_off.nil?
      attributes[:is_self_understanding] = self_understanding_score.to_i >= SELF_UNDERSTANDING_PASS_SCORE if user.is_self_understanding.nil?

      user.update(attributes)
    end
end
