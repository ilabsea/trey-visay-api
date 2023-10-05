# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                          :bigint(8)        not null, primary key
#  uuid                        :string(255)
#  full_name                   :string(255)      not null
#  password                    :string(255)      not null
#  username                    :string(255)      not null
#  sex                         :string(255)
#  date_of_birth               :date
#  phone_number                :string(255)
#  school_name                 :string(255)
#  grade                       :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  photo                       :string(255)
#  high_school_code            :string(255)
#  province_id                 :string(255)
#  district_id                 :string(255)
#  commune_code                :string(255)
#  class_group                 :integer
#  middle_school_id            :integer
#  device_id                   :string(255)
#  device_type                 :integer
#  device_os                   :integer
#  app_version                 :integer
#  registered_at               :datetime
#  other_grade                 :integer
#  holland_quizzes_count       :integer          default(0)
#  intelligence_quizzes_count  :integer          default(0)
#  is_complete_grade_twelve    :boolean
#  is_self_understanding       :boolean
#  is_selected_major_or_career :boolean
#  potential_drop_off          :boolean
#

require "csv"

class User < ApplicationRecord
  include HighSchools::LocationConcern

  mount_uploader :photo, ::PhotoUploader

  GRADES = %w[9 10 11 12 other].freeze
  PLATFORMS = [["Android", "android"], ["iOs", "ios"], ["Other", "other"]]
  PUBLIC_USER_ID = 0

  # Enum
  enum class_group: {
    science: 1,
    social_science: 2
  }

  enum device_type: {
    mobile: 1,
    tablet: 2
  }

  enum device_os: {
    android: 1,
    ios: 2,
    other: 3
  }

  enum other_grade: {
    under_grade_nine: 1,
    university_student: 2,
    other_occupation: 3
  }

  # Associaction
  # V2
  has_many :holland_quizzes, dependent: :destroy
  has_many :intelligence_quizzes, dependent: :destroy

  # V1
  belongs_to :high_school, foreign_key: :high_school_code, optional: true
  has_many :games
  has_many :personal_understandings, through: :games
  has_many :personality_tests

  # Validation
  validates :grade, inclusion: { in: GRADES }, allow_nil: true
  validates :full_name, presence: true

  # Delegation
  delegate :name_km, to: :high_school, prefix: :high_school, allow_nil: true

  # Callback
  before_create :set_username_password
  before_validation :set_district_id

  def school_address
    return nil unless high_school_code.present?

    "#{high_school_name_km} #{high_school.location.address_km}"
  end

  def display_device_id
    return device_id if device_id.to_s.length <= 6

    device_id.first(3) + "..." + device_id.last(3)
  end

  def display_grade
    grade_other? && other_grade.present? ? I18n.t("user.#{other_grade}") : grade
  end

  def grade_other?
    grade == "other"
  end

  def quizzes_count
    holland_quizzes_count + intelligence_quizzes_count
  end

  def self.grades
    [
      { value: 9, label: 9 },
      { value: 10, label: 10 },
      { value: 11, label: 11 },
      { value: 12, label: 12 },
      { value: "other", label: "ផ្សេងៗ" }
    ]
  end

  def self.filter(params)
    scop = all
    scop = scop.where(province_id: params[:province_id]) if params[:province_id].present?
    scop = scop.where(district_id: params[:district_id]) if params[:district_id].present?
    scop = scop.where(high_school_code: params[:high_school_code]) if params[:high_school_code].present?
    scop = scop.where(grade: params[:grade]) if params[:grade].present?
    scop
  end

  private
    def set_username_password
      self.username ||= full_name
      self.password ||= SecureRandom.uuid[0..5]
    end

    def set_district_id
      self.district_id ||= high_school.try(:district_id)
    end
end
