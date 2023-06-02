# frozen_string_literal: true

class SelfUnderstandingQuestionsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @questions = pagy(authorize SelfUnderstandingQuestion.includes(:options))
      }
    end
  end
end
