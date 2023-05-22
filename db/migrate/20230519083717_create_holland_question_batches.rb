# frozen_string_literal: true

class CreateHollandQuestionBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_question_batches, id: :string do |t|
      t.string  :code
      t.integer :total_count, default: 0
      t.integer :valid_count, default: 0
      t.integer :new_count, default: 0
      t.string  :reference
      t.integer :creator_id

      t.timestamps
    end
  end
end
