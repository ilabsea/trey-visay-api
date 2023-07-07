# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes, id: :string do |t|
      t.integer  :user_id
      t.datetime :quizzed_at
      t.string   :type

      t.timestamps
    end
  end
end
