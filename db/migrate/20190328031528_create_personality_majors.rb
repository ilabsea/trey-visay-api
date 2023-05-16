# frozen_string_literal: true

class CreatePersonalityMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :personality_majors, id: false do |t|
      t.primary_key :code, :string, limit: 36
      t.string :name_en
      t.string :name_km
      t.string :basic_knowledge
      t.string :study_credit
      t.text   :recieved_knowledge
      t.text :possible_workplaces

      t.timestamps
    end
  end
end
