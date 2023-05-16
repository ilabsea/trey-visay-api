# frozen_string_literal: true

class CreatePersonalities < ActiveRecord::Migration[5.1]
  def change
    create_table :personalities, id: false do |t|
      t.primary_key :code, :string, limit: 36
      t.string :name_km
      t.string :name_en
      t.string :category
      t.timestamps
    end

    add_index :personalities, :code, unique: true
  end
end
