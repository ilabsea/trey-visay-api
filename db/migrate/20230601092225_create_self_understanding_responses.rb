class CreateSelfUnderstandingResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :self_understanding_responses, id: :string do |t|
      t.string :holland_quiz_id
      t.string :self_understanding_question_id
      t.string :self_understanding_question_code
      t.string :value

      t.timestamps
    end
  end
end
