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
#  deleted_at  :datetime
#
class CareerWebsite < ApplicationRecord
  acts_as_paranoid

  mount_uploader :logo, ::LogoUploader

  # Validation
  validates :name, presence: true
  validates :url, presence: true
  validates :url, http_url: true

  # Callback
  before_create :secure_id

  def self.filter(params = {})
    scope = all
    scope = scope.where("name LIKE ?", "%#{params[:name].strip}%") if params[:name].present?
    scope = scope.where("updated_at >= ?", params[:updated_at]) if params[:updated_at].present?
    scope
  end
end
