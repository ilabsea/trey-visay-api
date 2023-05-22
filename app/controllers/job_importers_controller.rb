# frozen_string_literal: true

class JobImportersController < ApplicationController
  before_action :set_batch, only: [:edit, :update, :destroy]

  def index
    @pagy, @batches = pagy(authorize JobBatch.filter(filter_params).order(updated_at: :desc).includes(:jobs))
  end

  def new
    @batch = authorize JobBatch.new
  end

  def create
    authorize JobBatch, :create?

    if file = params[:job_batch][:file].presence
      @batch = Spreadsheets::JobBatchSpreadsheet.new.import(file)

      render :wizard_review, status: :see_other
    else
      create_job_batch
    end
  end

  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to job_importers_url, notice: "Job batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_batch
      @batch = authorize JobBatch.find_by(code: params[:code])
    end

    def create_job_batch
      @batch = JobBatch.new(job_batch_params)

      if @batch.save
        redirect_to jobs_url, notice: I18n.t("shared.import_success", count: @batch.jobs.length)
      else
        redirect_to new_job_importer_url, alert: I18n.t("shared.some_invalid_records")
      end
    end

    def job_batch_params
      params.require(:job_batch).permit(
        :code, :total_count, :valid_count, :new_count, :reference_cache,
        importing_jobs_attributes: [
          :job_id,
          job_attributes: [
            :id, :code, :name_km, :name_en, :personality_type,
            :general_description, :jd_main_task, :jd_environment,
            :jd_technology_skill, :edu_education_level,
            :edu_high_school_supported_subject, :edu_higher_education_skill,
            :qua_supported_knowledge, :qua_supported_skill,
            :qua_supported_capacity, :qua_characteristic_of_job,
            :info_job_market, :info_similar_job
          ]
        ]
      ).merge({
        creator_id: current_account.id
      })
    end

    def filter_params
      params.permit(:keyword)
    end
end
