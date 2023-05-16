# frozen_string_literal: true

namespace :career_game do
  desc "Migrate existing career ID to code"
  task migrate_existing_career_id_to_code: :environment do
    puts("CareerGame is migrating previous existing career ID to code")

    if ActiveRecord::Base.connection.column_exists?(:careers_games, :career_id)
      migration
    else
      puts "Career game career_id column did not present or has been removed"
    end

    puts("CareerGame code migration is completed!")
  end

  desc "Reverse migrate existing career ID to code"
  task reverse_migrate_existing_career_id_to_code: :environment do
    puts("CareerGame is reversing previous existing ID to code migration")

    if ActiveRecord::Base.connection.column_exists?(:careers_games, :career_id)
      reverse_migration
    else
      puts "Career game career_id column did not present or has been removed"
    end

    puts("CareerGame reversing code migration is completed!")
  end

  private
    def migration
      CareerGame.transaction do
        CareerGame.where.not(career_id: nil).each do |career_game|
          career = Career.find_by(id: career_game.career_id)

          next if career.nil?

          career_game.career_code = career.code
          career_game.save!
        end
      end
    end

    def reverse_migration
      CareerGame.transaction do
        CareerGame.where.not(career_id: nil).each do |career_game|
          career_game.career_code = nil
          career_game.save!
        end
      end
    end
end
