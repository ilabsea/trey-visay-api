# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :user_id, null: false
      t.integer :characteristic_id
      t.string  :reason, null: true
      t.string  :audio, null: true

      t.timestamps null: false
    end
  end
end
