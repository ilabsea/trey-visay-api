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
#  province_id         :string(255)
#  deleted_at          :datetime
#  display_order       :integer
#

class School < ApplicationRecord
  acts_as_paranoid

  include ItemableConcern

  mount_uploader :logo, LogoUploader

  enum kind: {
    higher_education: 1,
    tvet_institute: 2
  }

  has_many :school_departments, inverse_of: :school, dependent: :destroy
  has_many :departments, through: :school_departments
  has_many :school_majors, inverse_of: :school, dependent: :destroy
  has_many :majors, through: :school_majors

  validates :name, presence: true

  # Callback
  before_create :secure_code
  before_create :set_display_order

  # Nested attribute
  accepts_nested_attributes_for :school_departments, allow_destroy: true

  # Scope
  default_scope { order(display_order: :asc) }

  def self.t_kinds
    [
      [I18n.t("school.higher_education"), "higher_education"],
      [I18n.t("school.tvet_institute"), "tvet_institute"]
    ]
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("code LIKE ? or name LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    scope = scope.where(kind: params[:kind]) if params[:kind].present?
    scope = scope.where("updated_at >= ?", params[:updated_at]) if params[:updated_at].present?
    scope
  end

  def self.categories
    ["public", "private", "ngo"]
  end
end
