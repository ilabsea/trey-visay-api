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
  end

  desc "Migrate registered_at to have value as created_at"
  task migrate_to_have_registered_at: :environment do
    User.where(registered_at: nil).find_each do |user|
      user.update_columns(registered_at: user.created_at)
    end
  end

  desc "Update user supporting dashboard"
  task update_user_supporting_dashboard: :environment do
    users = User.where("holland_quizzes_count > 0").includes(holland_quizzes: [:holland_major_responses, :holland_job_responses, :self_understanding_responses])
    users.find_each do |user|
      quiz = user.holland_quizzes.sort_by(&:quizzed_at).first
      user.update(
        is_selected_major_or_career: (quiz.holland_major_response_ids.present? || quiz.holland_job_response_ids.present?),
        potential_drop_off: quiz.self_understanding_responses.where(self_understanding_question_code: %w(q1 q2), value: "unsure").present?,
        is_self_understanding: quiz.self_understanding_score.to_i >= HollandQuiz::SELF_UNDERSTANDING_PASS_SCORE
      )

      print "."
      $stdout.flush
    end

    puts "Update user supporting dashboard is completed!"
  end
end
