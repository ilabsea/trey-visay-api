# frozen_string_literal: true

class CreateSchoolMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :school_majors do |t|
      t.integer :major_id
      t.integer :school_id
      t.integer :department_id
      t.integer :school_department_id

      t.timestamps
    end
  end
end
