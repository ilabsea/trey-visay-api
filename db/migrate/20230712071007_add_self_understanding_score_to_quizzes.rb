# frozen_string_literal: true

class AddSelfUnderstandingScoreToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :self_understanding_score, :integer
  end
end
