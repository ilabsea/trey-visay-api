# frozen_string_literal: true

# == Schema Information
#
# Table name: careers_games
#
#  career_id   :bigint(8)
#  game_id     :bigint(8)
#  is_goal     :boolean          default(FALSE)
#  id          :bigint(8)        not null, primary key
#  career_code :string(255)
#
# Indexes
#
#  index_careers_games_on_career_code  (career_code)
#  index_careers_games_on_career_id    (career_id)
#  index_careers_games_on_game_id      (game_id)
#

class CareerGame < ApplicationRecord
  self.table_name = "careers_games"

  belongs_to :career, foreign_key: "career_code", primary_key: "code"
  belongs_to :game
end
