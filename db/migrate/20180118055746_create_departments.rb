# frozen_string_literal: true

class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.integer :school_id, null: false

      t.timestamps null: false
    end
  end
end
