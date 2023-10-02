# frozen_string_literal: true

namespace :user do
  desc "migrate user registered_at as data in v1 has no registered_at"
  task migrate_registered_at: :environment do
    User.where(registered_at: nil).find_each do |user|
      user.update_columns(registered_at: user.created_at)
    end
  end
end
