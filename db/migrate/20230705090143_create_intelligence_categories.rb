# frozen_string_literal: true

class CreateIntelligenceCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :intelligence_categories, id: :string do |t|
      t.string :code
      t.string :name_km
      t.string :name_en
      t.text   :description
      t.text   :appropriate_learning_method
      t.text   :suitable_job

      t.timestamps
    end
  end
end
