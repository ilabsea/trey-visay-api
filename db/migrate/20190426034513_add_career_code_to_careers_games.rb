# frozen_string_literal: true

class AddCareerCodeToCareersGames < ActiveRecord::Migration[5.1]
  def change
    add_column :careers_games, :career_code, :string
  end
end
