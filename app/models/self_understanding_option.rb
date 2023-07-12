# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_options
#
#  id                             :string(255)      not null, primary key
#  code                           :string(255)
#  name                           :string(255)
#  value                          :string(255)
#  self_understanding_question_id :string(255)
#  display_order                  :integer          default(1)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  score                          :integer
#
class SelfUnderstandingOption < ApplicationRecord
  # Association
  belongs_to :self_understanding_question

  # Validation
  validates :name, presence: true
  validates :value, presence: true

  # Callback
  before_create :secure_id
  before_create :secure_code
  before_create :set_display_order

  # Scope
  default_scope { order(display_order: :asc) }
end
