# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_questions
#
#  id                       :string(255)      not null, primary key
#  code                     :string(255)
#  name                     :string(255)
#  intelligence_category_id :string(255)
#  display_order            :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class IntelligenceQuestion < ApplicationRecord
  # Association
  belongs_to :intelligence_category

  # Callback
  before_create :secure_id
  before_create :secure_code
  before_create :set_display_order

  # Delegation
  delegate :name, to: :intelligence_category, prefix: true, allow_nil: true

  # Scope
  default_scope { order(display_order: :asc) }

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where(intelligence_category_id: params[:intelligence_category_id]) if params[:intelligence_category_id].present?
    scope
  end
end
