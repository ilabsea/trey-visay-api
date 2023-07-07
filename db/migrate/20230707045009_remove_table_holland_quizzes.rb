# frozen_string_literal: true

class RemoveTableHollandQuizzes < ActiveRecord::Migration[5.2]
  def change
    drop_table :holland_quizzes
  end
end
