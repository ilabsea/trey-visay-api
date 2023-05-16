# frozen_string_literal: true

class AddIndexCareerCodeToCareersGames < ActiveRecord::Migration[5.1]
  def change
    add_index :careers_games, :career_code
  end
end
