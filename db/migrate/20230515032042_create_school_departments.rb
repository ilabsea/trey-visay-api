# frozen_string_literal: true

class CreateSchoolDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :school_departments do |t|
      t.integer :school_id
      t.integer :department_id

      t.timestamps
    end
  end
end
