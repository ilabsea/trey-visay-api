# frozen_string_literal: true

# == Schema Information
#
# Table name: job_clusters
#
#  id             :string(255)      not null, primary key
#  code           :string(255)
#  name           :string(255)
#  display_order  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recommendation :text(65535)
#  deleted_at     :datetime
#  logo           :string(255)
#
class JobCluster < ApplicationRecord
  acts_as_paranoid

  include ItemableConcern

  # Uploader
  mount_uploader :logo, ::LogoUploader

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

  accepts_nested_attributes_for :cluster_videos, allow_destroy: true

  default_scope { order(display_order: :asc) }

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where("updated_at > ?", params[:updated_at]) if params[:updated_at].present?
    scope
  end
end
