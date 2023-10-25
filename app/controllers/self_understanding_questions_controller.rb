# frozen_string_literal: true

class SelfUnderstandingQuestionsController < ApplicationController
  def index
    respond_to do |format|
      format.html {
        @pagy, @questions = pagy(authorize_questions)
      }

      format.xlsx {
        @questions = authorize_questions

        if @questions.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to schools_url
        else
          render xlsx: "index", filename: "self_understanding_questions_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @questions = authorize_questions

        render json: @questions
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
    helper_method :filter_params

    def authorize_questions
      authorize SelfUnderstandingQuestion.filter(filter_params).includes(:options)
    end
end
