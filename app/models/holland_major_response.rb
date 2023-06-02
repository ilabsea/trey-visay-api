# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_major_responses
#
#  id               :string(255)      not null, primary key
#  holland_quiz_id  :string(255)
#  college_major_id :string(255)
#  selected         :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class HollandMajorResponse < ApplicationRecord
  belongs_to :quiz, class_name: :HollandQuiz, foreign_key: :holland_quiz_id
  belongs_to :college_major

  # Callback
  before_create :secure_id
end
