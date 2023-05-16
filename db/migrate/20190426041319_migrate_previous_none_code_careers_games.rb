# frozen_string_literal: true

class MigratePreviousNoneCodeCareersGames < ActiveRecord::Migration[5.1]
  def up
    Rake::Task["career_game:migrate_existing_career_id_to_code"].invoke
  end

  def down
    Rake::Task["career_game:reverse_migrate_existing_career_id_to_code"].invoke
  end
end
