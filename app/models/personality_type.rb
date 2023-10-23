# frozen_string_literal: true

# == Schema Information
#
# Table name: personality_types
#
#  id                :string(255)      not null, primary key
#  code              :string(255)
#  name_km           :string(255)
#  name_en           :string(255)
#  recommendation    :text(65535)
#  description       :text(65535)
#  personal_value    :text(65535)
#  skill_and_ability :text(65535)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class PersonalityType < ApplicationRecord
  # Soft delete
  acts_as_paranoid

  # Validation
  validates :code, presence: true
  validates :name_km, presence: true
  validates :name_en, presence: true
  validates :recommendation, presence: true
  validates :description, presence: true
  validates :personal_value, presence: true
  validates :skill_and_ability, presence: true

  # Callback
  before_create :secure_id

  # Scope
  default_scope { order(updated_at: :desc) }

  # Instant method
  def name
    self.send("name_#{I18n.locale}")
  end

  # Class method
  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name_en LIKE ? or name_km LIKE ?", "%#{params[:name].strip}%", "%#{params[:name].strip}%", "%#{params[:name].strip}%") if params[:name].present?
    scope = scope.where("updated_at >= ?", params[:updated_at]) if params[:updated_at].present?
    scope
  end
end
