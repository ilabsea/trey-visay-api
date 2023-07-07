# frozen_string_literal: true

module Api
  module V2
    class IntelligenceQuizzesController < ::Api::V2::ApiController
      def create
        quiz = IntelligenceQuiz.new(intelligence_quiz_short_params)

        if quiz.save
          IntelligenceQuizJob.perform_async(quiz.id, intelligence_quiz_params.as_json)

          render json: quiz, status: :created
        else
          render json: { error: quiz.errors }, status: :unprocessable_entity
        end
      end

      def update
        if quiz = IntelligenceQuiz.find(params[:id]).presence
          IntelligenceQuizJob.perform_async(quiz.id, intelligence_quiz_params.as_json)

          render json: quiz
        else
          render json: { error: quiz.errors }, status: :unprocessable_entity
        end
      end

      private
        def intelligence_quiz_short_params
          params.require(:intelligence_quiz).permit(:user_id, :quizzed_at)
        end

        def intelligence_quiz_params
          params.require(:intelligence_quiz).permit(
            :user_id, :quizzed_at,
            intelligence_scores_attributes: [:intelligence_category_code, :score],
            intelligence_responses_attributes: [:intelligence_question_code, :value]
          )
        end
    end
  end
end
