# frozen_string_literal: true

class MiddleSchoolsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @schools = pagy(authorize MiddleSchool.filter(filter_params))
      }

      format.xlsx {
        @schools = authorize MiddleSchool.filter(filter_params)

        if @schools.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i
          flash[:alert] = t("shared.file_size_is_too_big", max_record: ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i)
          redirect_to schools_url
        else
          render xlsx: "index", filename: "high_schools_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @schools = authorize MiddleSchool.filter(filter_params)

        render json: @schools
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
end
