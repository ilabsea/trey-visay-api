# frozen_string_literal: true

class CreateIntelligenceQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :intelligence_questions, id: :string do |t|
      t.string  :code
      t.string  :name
      t.string  :intelligence_category_id
      t.integer :display_order

      t.timestamps
    end
  end
end
