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
#  deleted_at :datetime
#
class Video < ApplicationRecord
  acts_as_paranoid

  include ItemableConcern

  # Association
  has_many :cluster_videos
  has_many :job_clusters, through: :cluster_videos

  # Callback
  before_create :secure_id
  before_create :secure_code

  # Validation
  validates :name, presence: true
  validates :url, presence: true
  validates :url, http_url: true
  validates :author, presence: true

  # Scope
  default_scope { order(created_at: :desc) }

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name].strip}%", "%#{params[:name].strip}%") if params[:name].present?
    scope = scope.where("updated_at >= ?", params[:updated_at]) if params[:updated_at].present?
    scope
  end

  # Instant method
  def youtube_id
    regex = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
    match = regex.match(url)
    if match && !match[1].blank?
      match[1]
    else
      nil
    end
  end

  def thumbnail
    "http://img.youtube.com/vi/#{youtube_id}/default.jpg"
  end
end
