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
#

class School < ApplicationRecord
  mount_uploader :logo, PhotoUploader

  CATEGORIES = %w[សាលារដ្ឋ សាលាឯកជន អង្គការ].freeze

  has_and_belongs_to_many :careers
  has_many :departments
  has_many :department_majors, through: :departments, source: :majors
  has_many :majors

  validates :category, inclusion: { in: CATEGORIES }
  validates :name, presence: true
end
