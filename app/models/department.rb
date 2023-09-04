# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grade      :integer
#

class Department < ApplicationRecord
  enum grade: {
    vocational_grade: 1
  }

  has_many :school_departments
  has_many :schools, through: :school_departments

  validates :name, presence: true
end
