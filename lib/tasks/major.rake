# frozen_string_literal: true

namespace :major do
  desc "Migrate major personality_type"
  task migrate_personality_type: :environment do
    all_types = PersonalityType.all

    Major.where.not(personality_type: nil).each do |major|
      codes = major.personality_type.split("")
      codes.each_with_index do |code, index|
        type = all_types.select { |t| t.code == code }.first

        major.major_personality_types.create(personality_type_id: type.id, display_order: index + 1) if type.present?
      end
    end
  end
end
