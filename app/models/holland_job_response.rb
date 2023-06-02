# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_job_responses
#
#  id              :string(255)      not null, primary key
#  holland_quiz_id :string(255)
#  job_id          :string(255)
#  selected        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class HollandJobResponse < ApplicationRecord
  belongs_to :quiz, class_name: :HollandQuiz, foreign_key: :holland_quiz_id
  belongs_to :job

  # Callback
  before_create :secure_id
end
