# frozen_string_literal: true

class AddGoalToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :goal, :string
  end
end
