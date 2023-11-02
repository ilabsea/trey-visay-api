# frozen_string_literal: true

namespace :holland_quiz do
  desc "Migrate holland quiz display order"
  task migrate_display_order: :environment do
    users = User.where(holland_quizzes_count > 0).includes(:holland_quizzes)
    users.each do |user|
      quizzes = user.holland_quizzes
      quizzes.each_with_index do |quiz, index|
        quiz.update_columns(display_order: index + 1)
      end
    end
  end
end
