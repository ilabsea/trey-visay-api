# frozen_string_literal: true

class CreateIntelligenceScores < ActiveRecord::Migration[5.2]
  def change
    create_table :intelligence_scores, id: :string do |t|
      t.string  :intelligence_quiz_id
      t.string  :intelligence_category_id
      t.integer :score

      t.timestamps
    end
  end
end
