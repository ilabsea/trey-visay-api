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
  has_many :school_majors
  has_many :schools, through: :school_majors
  has_many :school_departments, through: :school_majors

  validates :name, presence: true
end
