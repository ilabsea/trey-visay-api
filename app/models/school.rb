# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id                  :bigint(8)        not null, primary key
#  name                :string(255)      not null
#  logo                :string(255)
#  address             :string(255)
#  province            :string(255)
#  phone_numbers       :string(255)
#  faxes               :string(255)
#  emails              :string(255)
#  website_or_facebook :string(255)
#  mailbox             :string(255)
#  category            :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  code                :string(255)
#  kind                :integer
#

class School < ApplicationRecord
  include ItemableConcern

  mount_uploader :logo, PhotoUploader

  CATEGORIES = %w[សាលារដ្ឋ សាលាឯកជន អង្គការ].freeze

  enum kind: {
    higher_education: 1,
    vocational_education: 2
  }

  # has_and_belongs_to_many :careers
  has_many :school_departments, inverse_of: :school, dependent: :destroy
  has_many :departments, through: :school_departments
  has_many :school_majors
  has_many :majors, through: :school_majors

  # validates :category, inclusion: { in: CATEGORIES }
  validates :name, presence: true

  accepts_nested_attributes_for :school_departments, allow_destroy: true

  def display_id
    "school_#{id}"
  end

  def self.t_kinds
    [
      [I18n.t("school.higher_education"), "higher_education"],
      [I18n.t("school.vocational_education"), "vocational_education"]
    ]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where(kind: params[:kind]) if params[:kind].present?
    scope
  end
end
