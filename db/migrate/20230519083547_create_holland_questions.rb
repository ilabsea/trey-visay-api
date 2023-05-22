# frozen_string_literal: true

class CreateHollandQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_questions, id: :string do |t|
      t.string :code
      t.string :name
      t.string :personality_type
      t.integer :display_order

      t.timestamps
    end
  end
end
