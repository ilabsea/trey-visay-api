# frozen_string_literal: true

class AddFinishedAtToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :finished_at, :datetime
  end
end
