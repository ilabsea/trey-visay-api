# frozen_string_literal: true

class SchoolsController < ApplicationController
  before_action :authorize_school, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @pagy, @schools = pagy(authorize School.filter(filter_params).includes(:school_majors, :school_departments))
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

  def new
    @school = authorize School.new
  end

  def create
    @school = authorize School.new(school_params)

    if @school.save
      redirect_to schools_url, notice: "School was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to schools_url, notice: "School was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @school.destroy

    redirect_to schools_url, notice: "School was destroyed successfully"
  end

  private
    def filter_params
      params.permit(:name, :kind)
    end
    helper_method :filter_params

    def authorize_school
      @school = authorize School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(
        :code, :name, :logo, :remove_logo, :address, :phone_numbers,
        :emails, :website_or_facebook, :category, :kind, :province_id,
        school_departments_attributes: [ :id, :major_list, :_destroy, department_attributes: [:name, :grade] ]
      )
    end
end
