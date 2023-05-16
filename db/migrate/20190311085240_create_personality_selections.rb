# frozen_string_literal: true

class CreatePersonalitySelections < ActiveRecord::Migration[5.1]
  def change
    create_table :personality_selections do |t|
      t.string :personality_code
      t.integer :personality_test_id
    end
  end
end
