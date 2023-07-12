# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_responses
#
#  id                               :string(255)      not null, primary key
#  holland_quiz_id                  :string(255)
#  self_understanding_question_id   :string(255)
#  self_understanding_question_code :string(255)
#  value                            :string(255)
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
class SelfUnderstandingResponse < ApplicationRecord
  belongs_to :quiz, class_name: :HollandQuiz, foreign_key: :holland_quiz_id
  belongs_to :question, class_name: :SelfUnderstandingQuestion, foreign_key: :self_understanding_question_id
  has_one :user, through: :quiz

  # Callback
  before_create :secure_id
  before_validation :clean_emoji_on_value

  def clean_emoji_on_value
    self.value = RemoveEmoji::Sanitize.call(value.to_s).strip
  end
end
