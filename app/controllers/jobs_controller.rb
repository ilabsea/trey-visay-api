# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :authorize_job, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @pagy, @jobs = pagy(authorize Job.filter(filter_params).order(:code, created_at: :desc).includes(:schools, :job_cluster))
      }

      format.xlsx {
        @jobs = authorize Job.filter(filter_params).includes(:job_cluster).order(:job_cluster_id)

        if @jobs.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to jobs_url
        else
          render xlsx: "index", filename: "jobs_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @jobs = authorize Job.filter(filter_params).includes(:videos, :schools)

        render json: @jobs
      }
    end
  end

  def show
  end

  def new
    @job = authorize Job.new
  end

  def create
    @job = authorize Job.new(job_params)

    if @job.save
      redirect_to jobs_url, notice: "Job was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_url, notice: "Job was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy

    redirect_to jobs_url, notice: "Job was destroyed successfully"
  end

  private
    def filter_params
      params.permit(:name, :job_cluster_id)
    end
    helper_method :filter_params

    def authorize_job
      @job = authorize Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(
        :code, :name_km, :name_en, :personality_type, :general_description,
        :jd_main_task, :jd_environment, :jd_work_style, :edu_education_level,
        :edu_subjects_at_high_school, :edu_majors_at_university, :recommendation,
        :personal_competency_knowledge, :personal_competency_skill,
        :personal_competency_ability, :job_cluster_id, :logo, :remove_logo
      )
    end
end
