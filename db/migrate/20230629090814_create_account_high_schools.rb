# frozen_string_literal: true

class CreateAccountHighSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :account_high_schools do |t|
      t.string  :high_school_id
      t.integer :account_id

      t.timestamps
    end
  end
end
