# frozen_string_literal: true

class AddDisplayOrderToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :display_order, :integer
  end
end
