# frozen_string_literal: true

# == Schema Information
#
# Table name: intelligence_categories
#
#  id                          :string(255)      not null, primary key
#  code                        :string(255)
#  name_km                     :string(255)
#  name_en                     :string(255)
#  description                 :text(65535)
#  appropriate_learning_method :text(65535)
#  suitable_job                :text(65535)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
class IntelligenceCategory < ApplicationRecord
  # Validation
  validates :name_km, presence: true
  validates :name_en, presence: true

  # Callback
  before_create :secure_id
  before_create :secure_code

  def name
    self["name_#{I18n.locale}"]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name_km LIKE ? OR name_en LIKE ?", "%#{params[:name].strip}%", "%#{params[:name].strip}%", "%#{params[:name].strip}%") if params[:name].present?
    scope
  end
end
