# frozen_string_literal: true

namespace :user do
  desc "migrate user registered_at as data in v1 has no registered_at"
  task migrate_registered_at: :environment do
    User.where(registered_at: nil).find_each do |user|
      user.update_columns(registered_at: user.created_at)
    end
  end

  desc "migrate user potential drop off"
  task migrate_potential_drop_off: :environment do
    User.where(is_complete_grade_twelve: false).find_each do |user|
      user.update_columns(potential_drop_off: true)
    end

    User.where(is_complete_grade_twelve: true).find_each do |user|
      user.update_columns(potential_drop_off: false)
    end
  end
end
