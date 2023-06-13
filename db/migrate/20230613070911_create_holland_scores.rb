# frozen_string_literal: true

class CreateHollandScores < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_scores, id: :string do |t|
      t.string :holland_quiz_id
      t.string :personality_type
      t.integer :score

      t.timestamps
    end
  end
end
