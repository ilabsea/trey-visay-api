# frozen_string_literal: true

class HighSchoolsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @schools = pagy(authorize HighSchool.filter(filter_params))
      }

      format.xlsx {
        @schools = authorize HighSchool.filter(filter_params)

        if @schools.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to schools_url
        else
          render xlsx: "index", filename: "high_schools_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @schools = authorize HighSchool.filter(filter_params)

        render json: @schools
      }
    end
  end

  def grades
    render json: User.grades
  end

  private
    def filter_params
      params.permit(:name, :district_id)
    end
end
