# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id         :string(255)      not null, primary key
#  name_en    :string(255)      not null
#  name_km    :string(255)      not null
#  kind       :string(255)      not null
#  parent_id  :string(255)
#  latitude   :float(24)
#  longitude  :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  validates :name_en, :name_km, :kind, presence: true
  validates :kind, inclusion: { in: %w[province district commune village] }, allow_nil: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
  validate  :presence_of_lat_lng

  has_many   :children, class_name: "Location", foreign_key: :parent_id
  belongs_to :parent, class_name: "Location", optional: true

  before_create :secure_id

  def self.location_kind(id)
    return if id.blank?

    { 2 => "province", 4 => "district", 6 => "commune", 8 => "village" }[id.length]
  end

  private
    def presence_of_lat_lng
      return unless latitude.present? != longitude.present?

      errors.add(:longitude, "can't be blank") if latitude.present?
      errors.add(:latitude, "can't be blank") if longitude.present?
    end
end
