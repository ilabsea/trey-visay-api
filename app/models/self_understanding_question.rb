# frozen_string_literal: true

# == Schema Information
#
# Table name: self_understanding_questions
#
#  id            :string(255)      not null, primary key
#  code          :string(255)
#  name          :string(255)
#  type          :string(255)
#  display_order :integer          default(1)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  relevant      :string(255)
#
class SelfUnderstandingQuestion < ApplicationRecord
  # Association
  has_many :options, foreign_key: :self_understanding_question_id, class_name: "SelfUnderstandingOption", dependent: :destroy

  TYPES = [
    "Fields::SelectoneField",
    "Fields::SelectMultipleField",
    "Fields::TextInputField"
  ]

  # Validaiton
  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }

  # Callback
  before_create :secure_id
  before_create :secure_code
  before_create :set_display_order

  # Scope
  default_scope { order(display_order: :asc) }

  def relevant_question_code
    relevant.to_s.split("||")[0]
  end

  def relevant_question_value
    relevant.to_s.split("||")[2]
  end

  def operators
    {
      "=": "=="
    }
  end

  def operator
    operant = relevant.to_s.split("||")[1]

    operators[operant.to_s.to_sym]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name].strip}%", "%#{params[:name].strip}%") if params[:name].present?
    scope
  end
end
