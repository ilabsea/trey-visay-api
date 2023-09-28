# frozen_string_literal: true

class HighSchoolsController < ApplicationController
  before_action :authorize_school, only: [:edit, :update, :destroy]

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

  def new
    @school = authorize HighSchool.new
  end

  def create
    @school = authorize HighSchool.new(school_params)

    if @school.save
      redirect_to high_schools_url, notice: "High school was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to high_schools_url, notice: "High school was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @school.destroy

    redirect_to high_schools_url, notice: "High school was destroyed successfully"
  end

  private
    def filter_params
      params.permit(:name, :province_id, :district_id)
    end
    helper_method :filter_params

    def authorize_school
      @school = authorize HighSchool.find(params[:id])
    end

    def school_params
      params.require(:high_school).permit(
        :code, :name_km, :name_en, :district_id, :province_id
      )
    end
end
