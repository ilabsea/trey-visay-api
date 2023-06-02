class CreateHollandMajorResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_major_responses, id: :string do |t|
      t.string :holland_quiz_id
      t.string :college_major_id
      t.boolean :selected

      t.timestamps
    end
  end
end
