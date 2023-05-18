# frozen_string_literal: true

class SchoolImportersController < ApplicationController
  before_action :set_school_batch, only: [:edit, :update, :destroy]

  def index
    @pagy, @batches = pagy(authorize SchoolBatch.filter(filter_params).order(updated_at: :desc).includes(:schools))
  end

  def new
    @batch = authorize SchoolBatch.new
  end

  def create
    authorize SchoolBatch, :create?

    if file = params[:school_batch][:file].presence
      @batch = Spreadsheets::SchoolBatchSpreadsheet.new.import(file)

      render :wizard_review, status: :see_other
    else
      create_school_batch
    end
  end

  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to school_importers_url, notice: "Higher education school batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_school_batch
      @batch = authorize SchoolBatch.find_by(code: params[:code])
    end

    def create_school_batch
      @batch = SchoolBatch.new(school_batch_params)

      if @batch.save
        redirect_to schools_url, notice: I18n.t("shared.import_success", count: @batch.schools.length)
      else
        redirect_to new_school_importer_url, alert: I18n.t("shared.some_invalid_records")
      end
    end

    def school_batch_params
      params.require(:school_batch).permit(
        :code, :total_count, :valid_count, :province_count, :new_count, :reference_cache,
        importing_schools_attributes: [
          :school_id,
          school_attributes: [
            :id, :code, :name, :address, :province, :phone_numbers, :emails, :website_or_facebook, :kind, :category,
            school_departments_attributes: [
              :id, :_destroy,
              department_attributes: [:name],
              school_majors_attributes: [major_attributes: [:name]]
            ]
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
