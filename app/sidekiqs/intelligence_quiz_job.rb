# frozen_string_literal: true

class IntelligenceQuizJob
  include Sidekiq::Job

  def perform(quiz_id, params = {})
    quiz = IntelligenceQuiz.find(quiz_id)
    quiz.update!(quiz_params(params))
  end

  private
    def quiz_params(params)
      ActionController::Parameters.new(params)
        .permit(
          :user_id, :quizzed_at, :finished_at,
          intelligence_scores_attributes: [:intelligence_category_code, :score],
          intelligence_responses_attributes: [:intelligence_question_code, :value]
        )
    end
end
