# frozen_string_literal: true

module Api
  module V2
    class HollandQuizzesController < ::Api::V2::ApiController
      def create
        quiz = HollandQuiz.new(holland_quiz_params)

        if quiz.save
          render json: quiz, status: :created
        else
          render json: { error: quiz.errors }, status: :unprocessable_entity
        end
      end

      def update
        quiz = HollandQuiz.find(params[:id])

        if quiz.update(holland_quiz_params)
          render json: quiz
        else
          render json: { error: quiz.errors }, status: :unprocessable_entity
        end
      end

      private
        def holland_quiz_params
          params.require(:holland_quiz).permit(
            :user_id, :college_major_id, :job_id, :quizzed_at,
            :selected_college_major_at, :selected_job_at,
            personality_type_results: [],
            self_understanding_responses_attributes: [:self_understanding_question_id, :self_understanding_question_code, :value],
            holland_responses_attributes: [:holland_question_id, :holland_question_code, :value],
            holland_major_responses_attributes: [:college_major_id, :selected],
            holland_job_responses_attributes: [:job_id, :selected]
          )
        end
    end
  end
end
