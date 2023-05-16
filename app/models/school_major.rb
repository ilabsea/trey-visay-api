# frozen_string_literal: true

# == Schema Information
#
# Table name: school_majors
#
#  id                   :bigint(8)        not null, primary key
#  major_id             :integer
#  school_id            :integer
#  department_id        :integer
#  school_department_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class SchoolMajor < ApplicationRecord
  # Association
  belongs_to :school_department
  belongs_to :school, optional: true
  belongs_to :department, optional: true
  belongs_to :major

  # Callback
  after_create :set_school_and_department

  # Instant method
  def major_attributes=(hash)
    self.major = Major.find_or_create_by(name: hash[:name])
  end

  private
    def set_school_and_department
      self.update_columns(school_id: school_department.school_id, department_id: school_department.department_id)
    end
end
