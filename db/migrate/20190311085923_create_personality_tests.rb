# frozen_string_literal: true

class CreatePersonalityTests < ActiveRecord::Migration[5.1]
  def change
    create_table :personality_tests do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
