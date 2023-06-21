# frozen_string_literal: true

class HollandQuizzesController < ApplicationController
  before_action :set_user

  def show
    @quiz = HollandQuiz.find(params[:id])
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
