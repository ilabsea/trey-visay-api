# frozen_string_literal: true

class HollandQuestionsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @holland_questions = pagy(authorize HollandQuestion.filter(filter_params).order(display_order: :asc))
      }

      format.xlsx {
        @holland_questions = authorize HollandQuestion.filter(filter_params).order(display_order: :asc)

        if @holland_questions.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i
          flash[:alert] = t("shared.file_size_is_too_big", max_record: ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i)
          redirect_to holland_questions_url
        else
          render xlsx: "index", filename: "holland_questions#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
end
