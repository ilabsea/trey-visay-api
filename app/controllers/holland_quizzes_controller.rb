# frozen_string_literal: true

class HollandQuizzesController < ApplicationController
  before_action :set_user

  def show
    @quiz = HollandQuiz.find(params[:id])
    @questions = SelfUnderstandingQuestion.includes(:options)
    @holland_major_responses = @quiz.holland_major_responses.includes(:college_major)
    @holland_job_responses = @quiz.holland_job_responses.includes(:job)
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
