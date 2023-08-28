# frozen_string_literal: true

# == Schema Information
#
# Table name: school_departments
#
#  id            :bigint(8)        not null, primary key
#  school_id     :integer
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class SchoolDepartment < ApplicationRecord
  # Association
  belongs_to :school
  belongs_to :department
  has_many :school_majors, inverse_of: :school_department, dependent: :destroy
  has_many :majors, through: :school_majors

  # Nested attributes
  accepts_nested_attributes_for :school_majors, allow_destroy: true

  # Delegation
  delegate :name, to: :department, prefix: :department

  # Instant method
  def department_attributes=(hash)
    self.department = Department.find_or_create_by(name: hash[:name])
    self.department.update_columns(grade: hash[:grade])
  end
end
