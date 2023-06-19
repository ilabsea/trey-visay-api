# frozen_string_literal: true

# == Schema Information
#
# Table name: job_clusters
#
#  id            :string(255)      not null, primary key
#  code          :string(255)
#  name          :string(255)
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class JobCluster < ApplicationRecord
  # Validation
  validates :name, presence: true

  # Callback
  before_create :secure_id
  before_create :secure_code
  before_create :set_display_order

  # Association
  has_many :jobs
  has_many :cluster_videos
  has_many :videos, through: :cluster_videos

  default_scope { order(display_order: :asc) }

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope
  end
end
