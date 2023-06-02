class CreateSelfUnderstandingQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :self_understanding_questions, id: :string do |t|
      t.string  :code
      t.string  :name
      t.string  :type
      t.integer :display_order, default: 1

      t.timestamps
    end
  end
end
