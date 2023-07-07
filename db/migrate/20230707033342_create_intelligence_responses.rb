# frozen_string_literal: true

class CreateIntelligenceResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :intelligence_responses, id: :string do |t|
      t.string  :intelligence_quiz_id
      t.string  :intelligence_question_id
      t.string  :intelligence_question_code
      t.integer :value

      t.timestamps
    end
  end
end
