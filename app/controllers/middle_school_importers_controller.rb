# frozen_string_literal: true

class MiddleSchoolImportersController < ApplicationController
  before_action :set_batch, only: [:edit, :update, :destroy]

  def index
    @pagy, @batches = pagy(authorize MiddleSchoolBatch.filter(filter_params).order(updated_at: :desc).includes(:middle_schools))
  end

  def new
    @batch = authorize MiddleSchoolBatch.new
  end

  def create
    authorize MiddleSchoolBatch, :create?

    if file = params[:middle_school_batch][:file].presence
      @batch = Spreadsheets::MiddleSchoolBatchSpreadsheet.new.import(file)

      render :wizard_review, status: :see_other
    else
      create_middle_school_batch
    end
  end

  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to middle_school_importers_url, notice: "Middle school batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_batch
      @batch = authorize MiddleSchoolBatch.find_by(code: params[:code])
    end

    def create_middle_school_batch
      @batch = MiddleSchoolBatch.new(middle_school_batch_params)

      if @batch.save
        redirect_to middle_schools_url, notice: I18n.t("shared.import_success", count: @batch.middle_schools.length)
      else
        redirect_to new_middle_school_importer_url, alert: I18n.t("shared.some_invalid_records")
      end
    end

    def middle_school_batch_params
      params.require(:middle_school_batch).permit(
        :code, :total_count, :valid_count, :province_count, :new_count, :reference_cache,
        importing_middle_schools_attributes: [
          :middle_school_id,
          middle_school_attributes: [:id, :code, :name, :commune_id]
        ]
      ).merge({
        creator_id: current_account.id
      })
    end

    def filter_params
      params.permit(:keyword)
    end
end
