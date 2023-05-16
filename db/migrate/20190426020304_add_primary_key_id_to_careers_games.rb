# frozen_string_literal: true

class AddPrimaryKeyIdToCareersGames < ActiveRecord::Migration[5.1]
  def change
    add_column :careers_games, :id, :primary_key, null: false, unique: true, auto_increment: true
  end
end
