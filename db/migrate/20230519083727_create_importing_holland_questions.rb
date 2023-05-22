# frozen_string_literal: true

class CreateImportingHollandQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :importing_holland_questions do |t|
      t.string :holland_question_id
      t.string :holland_question_batch_id

      t.timestamps
    end
  end
end
