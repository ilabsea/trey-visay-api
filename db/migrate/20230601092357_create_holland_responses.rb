class CreateHollandResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_responses, id: :string do |t|
      t.string :holland_quiz_id
      t.string :holland_question_id
      t.string :holland_question_code
      t.integer :value

      t.timestamps
    end
  end
end
