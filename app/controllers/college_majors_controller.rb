# frozen_string_literal: true

class CollegeMajorsController < ApplicationController
  helper_method :filter_params
  before_action :set_college_major, only: [:show, :edit, :update]

  def index
    respond_to do |format|
      format.html {
        @pagy, @majors = pagy(authorize CollegeMajor.filter(filter_params).includes(:majors, :schools))
      }

      format.xlsx {
        @majors = authorize CollegeMajor.filter(filter_params)

        if @majors.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i
          flash[:alert] = t("shared.file_size_is_too_big", max_record: ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i)
          redirect_to majors_url
        else
          render xlsx: "index", filename: "majors_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @majors = authorize CollegeMajor.filter(filter_params)

        render json: @majors
      }
    end
  end

  def show
  end

  def edit
    @majors = Major.all
  end

  def update
    if @major.update(major_params)
      redirect_to @major
    else
      render :edit
    end
  end

  private
    def filter_params
      params.permit(:name)
    end

    def major_params
      params.require(:college_major).permit(major_ids: [])
    end

    def set_college_major
      @major = authorize CollegeMajor.find(params[:id])
    end
end
