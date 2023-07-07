# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_responses
#
#  id                         :string(255)      not null, primary key
#  intelligence_quiz_id       :string(255)
#  intelligence_question_id   :string(255)
#  intelligence_question_code :string(255)
#  value                      :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class IntelligenceResponse < ApplicationRecord
  belongs_to :quiz, class_name: :IntelligenceQuiz, foreign_key: :intelligence_quiz_id
  belongs_to :question, class_name: :IntelligenceQuestion, foreign_key: :intelligence_question_id

  # Callback
  before_create :secure_id
end
