# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  uuid             :string(255)
#  full_name        :string(255)      not null
#  password         :string(255)      not null
#  username         :string(255)      not null
#  sex              :string(255)
#  date_of_birth    :date
#  phone_number     :string(255)
#  school_name      :string(255)
#  grade            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  photo            :string(255)
#  high_school_code :string(255)
#  province_code    :string(255)
#  district_code    :string(255)
#  commune_code     :string(255)
#

require 'csv'

class User < ApplicationRecord
  mount_uploader :photo, ::PhotoUploader

  GRADES = %w[9 10 11 12 other].freeze

  belongs_to :high_school, foreign_key: :high_school_code, optional: true
  has_many :games
  has_many :personal_understandings, through: :games
  has_many :personality_tests

  validates :grade, inclusion: { in: GRADES }, allow_nil: true

  delegate :name_km, to: :high_school, prefix: :high_school, allow_nil: true

  def address
    return nil if high_school_code.blank?
    district = high_school.location
    "#{commune.try(:name_km)} #{district.name_km} #{district.province.name_km}"
  end

  def commune
    Pumi::Commune.find_by_id(commune_code)
  end

  def district
    Pumi::District.find_by_id(district_code)
  end

  def province
    Pumi::Province.find_by_id(province_code)
  end

  def high_school_label
    return nil if high_school_code.blank?

    "#{province.name_km} > #{district.name_km} > #{high_school.name_km}"
  end

  def self.grades
    [
      { value: 9, label: 9 },
      { value: 10, label: 10 },
      { value: 11, label: 11 },
      { value: 12, label: 12 },
      { value: 'other', label: 'ផ្សេងៗ' }
    ]
  end

  def self.filter(params)
    relation = all
    relation = relation.where(province_code: params[:province_code]) if params[:province_code].present?
    relation = relation.where(district_code: params[:district_code]) if params[:district_code].present?
    relation = relation.where(high_school_code: params[:high_school_code]) if params[:high_school_code].present?
    relation = relation.where(grade: params[:grade]) if params[:grade].present?
    relation
  end
end
