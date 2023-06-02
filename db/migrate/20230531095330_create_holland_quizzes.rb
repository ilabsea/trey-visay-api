class CreateHollandQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :holland_quizzes, id: :string do |t|
      t.integer :user_id
      t.string  :personality_type_results
      t.string  :college_major_id
      t.string  :job_id
      t.datetime :quizzed_at
      t.datetime :selected_college_major_at
      t.datetime :selected_job_at

      t.timestamps
    end
  end
end
