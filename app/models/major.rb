# frozen_string_literal: true

# == Schema Information
#
# Table name: majors
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Major < ApplicationRecord
  # Association
  has_many :major_mappings
  has_many :college_majors, through: :major_mappings

  has_many :school_majors
  has_many :schools, through: :school_majors
  has_many :school_departments, through: :school_majors

  # Validation
  validates :name, presence: true
end
