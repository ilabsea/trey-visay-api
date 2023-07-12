# frozen_string_literal: true

module Api
  module V2
    class HollandQuizzesController < ::Api::V2::ApiController
      def create
        quiz = HollandQuiz.new(holland_quiz_short_params)

        if quiz.save
          HollandQuizJob.perform_async(quiz.id, holland_quiz_params.as_json)

          render json: quiz, status: :created
        else
          render json: { error: quiz.errors }, status: :unprocessable_entity
        end
      end

      def update
        if quiz = HollandQuiz.find(params[:id]).presence
          HollandQuizJob.perform_async(quiz.id, holland_quiz_params.as_json)

          render json: quiz
        else
          render json: { error: quiz.errors }, status: :unprocessable_entity
        end
      end

      private
        def holland_quiz_short_params
          params.require(:holland_quiz).permit(:user_id, :quizzed_at)
        end

        def holland_quiz_params
          params.require(:holland_quiz).permit(
            :user_id, :quizzed_at, :finished_at, :self_understanding_score,
            self_understanding_responses_attributes: [:self_understanding_question_code, :value],
            holland_scores_attributes: [:personality_type, :score],
            holland_responses_attributes: [:holland_question_code, :value],
            holland_major_responses_attributes: [:college_major_code, :selected],
            holland_job_responses_attributes: [:job_code, :selected]
          )
        end
    end
  end
end
