# frozen_string_literal: true

class CreateHighSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :high_schools, id: false do |t|
      t.primary_key :code, :string, limit: 7
      t.string :name_km
      t.string :name_en
      t.string :location_code
    end

    add_index :high_schools, :code, unique: true
  end
end
