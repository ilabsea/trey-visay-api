# frozen_string_literal: true

# == Schema Information
#
# Table name: holland_questions
#
#  id               :string(255)      not null, primary key
#  code             :string(255)
#  name             :string(255)
#  personality_type :string(255)
#  display_order    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class HollandQuestion < ApplicationRecord
  PERSONALITY_TYPES = %w(R I A S E C)

  # Validation
  validates :name, presence: true
  validates :personality_type, presence: true, inclusion: { in: PERSONALITY_TYPES }

  # Association
  has_many :importing_holland_questions
  has_many :holland_question_batches, through: :importing_holland_questions

  # Callback
  before_create :secure_id
  before_create :secure_code
  before_create :set_display_order

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope
  end
end
