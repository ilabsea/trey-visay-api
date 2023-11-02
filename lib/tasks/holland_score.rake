# frozen_string_literal: true

namespace :holland_score do
  desc "Migrate holland score order number"
  task migrate_display_order: :environment do
    quizzes = HollandQuiz.all.includes(:holland_scores)
    quizzes.each do |quiz|
      quiz.holland_scores.each_with_index do |hs, index|
        hs.update_columns(display_order: index + 1)
      end
    end
  end
end
