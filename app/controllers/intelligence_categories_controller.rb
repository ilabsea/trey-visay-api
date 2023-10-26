# frozen_string_literal: true

class IntelligenceCategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html {
        @pagy, @categories = pagy(authorize_categories)
      }

      format.xlsx {
        @categories = authorize_categories

        if @categories.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to intelligence_categories_url
        else
          render xlsx: "index", filename: "intelligence_categories_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @categories = authorize authorize_categories

        render json: @categories
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
    helper_method :filter_params

    def authorize_categories
      authorize IntelligenceCategory.filter(filter_params)
    end
end
