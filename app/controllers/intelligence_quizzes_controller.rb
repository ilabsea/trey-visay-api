# frozen_string_literal: true

class IntelligenceQuizzesController < ApplicationController
  before_action :set_user

  def show
    @quiz = IntelligenceQuiz.find(params[:id])
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
