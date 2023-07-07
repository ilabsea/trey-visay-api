# frozen_string_literal: true

class IntelligenceQuestionsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @questions = pagy(authorize IntelligenceQuestion.filter(filter_params))
      }

      format.xlsx {
        @questions = authorize IntelligenceQuestion.filter(filter_params)

        if @questions.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to intelligence_questions_url
        else
          render xlsx: "index", filename: "intelligence_questions_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @questions = authorize IntelligenceQuestion.filter(filter_params)

        render json: @questions
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
end
