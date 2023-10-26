# frozen_string_literal: true

class CreateMajorPersonalityTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :major_personality_types do |t|
      t.string  :major_id
      t.string  :personality_type_id
      t.integer :display_order

      t.timestamps
    end
  end
end
