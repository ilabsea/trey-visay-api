# frozen_string_literal: true

class SchoolsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @schools = pagy(authorize School.filter(filter_params).includes(school_departments: [:majors, :department]))
      }

      format.xlsx {
        @schools = authorize School.filter(filter_params)

        if @schools.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to schools_url
        else
          render xlsx: "index", filename: "schools_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @schools = authorize School.filter(filter_params).includes(school_departments: [:department, :majors])

        render json: @schools
      }
    end
  end

  def show
    @school = School.find(params[:id])
  end

  private
    def filter_params
      params.permit(:name, :kind)
    end
end
