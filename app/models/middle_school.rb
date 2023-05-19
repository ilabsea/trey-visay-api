# frozen_string_literal: true

# == Schema Information
#
# Table name: middle_schools
#
#  id          :string(8)        not null, primary key
#  code        :string(255)
#  name        :string(255)
#  province_id :string(255)
#  district_id :string(255)
#  commune_id  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MiddleSchool < ApplicationRecord
  include MiddleSchools::LocationConcern

  # Association
  has_many :importing_middle_schools, inverse_of: :middle_school, dependent: :destroy
  has_many :middle_school_batches, through: :importing_middle_schools

  # Validation
  validates :name, presence: true
  validates :commune_id, presence: true
  validate :valid_commune

  # Callback
  before_create :set_province_id_and_district_id
  before_create :secure_id
  before_create :generate_code

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? OR name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope
  end

  private
    def valid_commune
      errors.add :commune_id, "is invalid" unless Pumi::Commune.find_by_id(commune_id).present?
    end

    def generate_code
      num = self.class.where("commune_id": commune_id).length + 1

      self.code ||= "#{commune_id}_#{sprintf("%02d", num)}"
    end
end
