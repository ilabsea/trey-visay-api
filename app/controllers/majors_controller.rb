# frozen_string_literal: true

class MajorsController < ApplicationController
  helper_method :filter_params
  before_action :set_major, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @pagy, @majors = pagy(authorize Major.filter(filter_params).includes(:parent, :schools))
      }

      format.xlsx {
        @majors = authorize Major.filter(filter_params)

        if @majors.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to majors_url
        else
          render xlsx: "index", filename: "majors_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @majors = authorize Major.filter(filter_params)

        render json: @majors
      }
    end
  end

  def show
  end

  def new
    @major = authorize Major.new
  end

  def create
    @major = authorize Major.new(major_params)

    if @major.save
      redirect_to majors_url, notice: I18n.t("shared.create_success", name: I18n.t("sidebar.college_major"))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @major.update(major_params)
      redirect_to @major, notice: I18n.t("shared.update_success", name: I18n.t("sidebar.college_major"))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @major.destroy

    redirect_to majors_url, notice: I18n.t("shared.delete_success", name: I18n.t("sidebar.college_major"))
  end

  private
    def filter_params
      params.permit(:name)
    end

    def major_params
      params.require(:major).permit(
        :name, :personality_type, :general_info,
        :orien_orientation_subjects, :orien_study_condition,
        :orien_graduation_condition, :curriculum,
        :teaching_and_learning_process, :gain_knowledge,
        :worthy_career, :recommendation
      )
    end

    def set_major
      @major = authorize Major.find(params[:id])
    end
end
