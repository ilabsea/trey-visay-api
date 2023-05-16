# frozen_string_literal: true

class CreateMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :majors do |t|
      t.string :name, null: false
      t.integer :department_id, null: true
      t.integer :school_id, null: false

      t.timestamps null: false
    end
  end
end
