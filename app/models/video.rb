# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :string(255)      not null, primary key
#  code       :string(255)
#  name       :string(255)
#  url        :string(255)
#  author     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Video < ApplicationRecord
  # Association
  has_many :importing_items, as: :itemable
  has_many :batches, through: :importing_items

  # Callback
  before_create :secure_id
  before_create :secure_code

  # Validation
  validates :name, presence: true
  validates :url, http_url: true
  validates :author, presence: true

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope
  end
end
