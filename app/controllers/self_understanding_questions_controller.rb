# frozen_string_literal: true

class SelfUnderstandingQuestionsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @questions = pagy(authorize SelfUnderstandingQuestion.includes(:options))
      }

      format.xlsx {
        @questions = authorize SelfUnderstandingQuestion.includes(:options)

        if @questions.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to schools_url
        else
          render xlsx: "index", filename: "self_understanding_questions_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @questions = authorize SelfUnderstandingQuestion.includes(:options)

        render json: @questions
      }
    end
  end
end
