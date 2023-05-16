# frozen_string_literal: true

class CreatePersonalityCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :personality_categories, id: false do |t|
      t.primary_key :code, :string, limit: 36
      t.string :name_en
      t.string :name_km
      t.string :group
      t.text   :description

      t.timestamps
    end
  end
end
