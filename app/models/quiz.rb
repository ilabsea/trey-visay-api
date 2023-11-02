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
class Quiz < ApplicationRecord
  # Callback
  before_create :secure_id

  # Scope
  default_scope { order(quizzed_at: :asc) }

  private
    def set_display_order
      self.display_order = self.class.where(user_id: user_id).maximum(:display_order).to_i + 1
    end
end
