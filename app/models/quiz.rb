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
class Quiz < ApplicationRecord
  # Association
  belongs_to :user

  # Callback
  before_create :secure_id

  # Scope
  default_scope { order(quizzed_at: :asc) }
end
