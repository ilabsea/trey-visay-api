# frozen_string_literal: true

class HollandQuizJob
  include Sidekiq::Job

  def perform(quiz_id, params = {})
    quiz = HollandQuiz.find(quiz_id)
    quiz.update!(quiz_params(params))
  end

  private
    def quiz_params(params)
      ActionController::Parameters.new(params)
        .permit(
          :user_id, :quizzed_at, :finished_at, :self_understanding_score,
          self_understanding_responses_attributes: [:self_understanding_question_code, :value],
          holland_scores_attributes: [:personality_type, :score],
          holland_responses_attributes: [:holland_question_code, :value],
          holland_major_responses_attributes: [:college_major_code, :selected],
          holland_job_responses_attributes: [:job_code, :selected]
        )
    end
end
