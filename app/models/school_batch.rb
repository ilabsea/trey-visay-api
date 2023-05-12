# frozen_string_literal: true

# == Schema Information
#
# Table name: school_batches
#
#  id             :string(8)        not null, primary key
#  code           :string(255)
#  total_count    :integer          default(0)
#  valid_count    :integer          default(0)
#  new_count      :integer          default(0)
#  province_count :integer          default(0)
#  reference      :string(255)
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class SchoolBatch < ApplicationRecord
  # Uploader
  mount_uploader :reference, AttachmentUploader

  # Association
  belongs_to :creator, class_name: "Account"
  has_many :importing_schools
  has_many :schools, through: :importing_schools

  # Callback
  before_create :secure_id
  before_create :secure_code

  # Delegation
  delegate :email, to: :creator, prefix: :creator, allow_nil: true

  # Nested attributes
  accepts_nested_attributes_for :importing_schools

  # Instant method
  def edit_count
    valid_count - new_count
  end

  def invalid_count
    total_count - valid_count
  end

  # Class method
  def self.filter(params)
    keyword = params[:keyword].to_s.strip
    scope = all
    scope = scope.where("code LIKE ? OR filename LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
    scope
  end
end
