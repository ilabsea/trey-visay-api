# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_responses
#
#  id                    :string(255)      not null, primary key
#  holland_quiz_id       :string(255)
#  holland_question_id   :string(255)
#  holland_question_code :string(255)
#  value                 :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class HollandResponse < ApplicationRecord
  belongs_to :quiz, class_name: :HollandQuiz, foreign_key: :holland_quiz_id
  belongs_to :question, class_name: :HollandQuestion, foreign_key: :holland_question_id

  # Callback
  before_create :secure_id
  before_validation :clean_emoji_on_value

  def clean_emoji_on_value
    self.value = RemoveEmoji::Sanitize.call(value.to_s).strip
  end
end
