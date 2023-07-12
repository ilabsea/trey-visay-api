# frozen_string_literal: true

class AddHollandQuizCountAndIntelligenceQuizCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :holland_quizzes_count, :integer, default: 0
    add_column :users, :intelligence_quizzes_count, :integer, default: 0
    add_column :users, :is_complete_grade_twelve, :boolean
    add_column :users, :is_self_understanding, :boolean
  end
end
