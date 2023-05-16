# frozen_string_literal: true

class RemoveSchoolIdFromDepartmentsAndMajors < ActiveRecord::Migration[5.2]
  def change
    remove_column :departments, :school_id
    remove_column :majors, :school_id
    remove_column :majors, :department_id
  end
end
