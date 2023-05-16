# frozen_string_literal: true

class CreateCareersGames < ActiveRecord::Migration[5.1]
  def change
    create_table :careers_games, id: false  do |t|
      t.belongs_to :career, index: true
      t.belongs_to :game, index: true
      t.boolean :is_goal, default: false
    end
  end
end
