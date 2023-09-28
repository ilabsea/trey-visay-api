# frozen_string_literal: true

# == Schema Information
#
# Table name: high_schools
#
#  code        :string(10)       not null, primary key
#  name_km     :string(255)
#  name_en     :string(255)
#  district_id :string(255)
#  province_id :string(255)
#  commune_id  :string(255)
#  deleted_at  :datetime
#
# Indexes
#
#  index_high_schools_on_code  (code) UNIQUE
#

class HighSchool < ApplicationRecord
  acts_as_paranoid

  include HighSchools::LocationConcern
  include ItemableConcern

  # Association
  has_many :users, foreign_key: :high_school_code

  validates :name_km, presence: true
  validates :district_id, presence: true

  # Callback
  before_create :secure_code
  before_create :set_name_en

  # Scope
  default_scope { order(district_id: :asc) }

  def location
    Pumi::District.find_by_id(district_id)
  end

  def name
    self["name_#{I18n.locale}"]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name_km LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where(province_id: params[:province_id]) if params[:province_id].present?
    scope = scope.where(district_id: params[:district_id]) if params[:district_id].present?
    scope
  end

  private
    def secure_code
      num = self.class.where("district_id": district_id).length + 1

      self.code ||= "#{district_id}#{sprintf("%03d", num)}"
    end

    def set_name_en
      self.name_en ||= name_km
    end
end
