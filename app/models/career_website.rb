# frozen_string_literal: true

# == Schema Information
#
# Table name: career_websites
#
#  id          :string(255)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  logo        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class CareerWebsite < ApplicationRecord
  mount_uploader :logo, ::LogoUploader

  # Validation
  validates :name, presence: true
  validates :url, presence: true
  validates :url, http_url: true

  # Callback
  before_create :secure_id

  def logo_or_default
    logo_url || "default_logo.png"
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("name LIKE ?", "%#{params[:name].strip}%") if params[:name].present?
    scope
  end
end
