# frozen_string_literal: true

class CreateEntriesGames < ActiveRecord::Migration[5.1]
  def change
    create_table :entries_games, id: false do |t|
      t.belongs_to :entry, index: true
      t.belongs_to :game, index: true
    end
  end
end
