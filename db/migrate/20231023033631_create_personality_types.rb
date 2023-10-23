# frozen_string_literal: true

class CreatePersonalityTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :personality_types, id: :string do |t|
      t.string   :code
      t.string   :name_km
      t.string   :name_en
      t.text     :recommendation
      t.text     :description
      t.text     :personal_value
      t.text     :skill_and_ability
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
