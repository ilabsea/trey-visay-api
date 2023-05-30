# frozen_string_literal: true

class CollegeMajorImportersController < ApplicationController
  before_action :set_batch, only: [:edit, :update, :destroy]

  def index
    @pagy, @batches = pagy(authorize CollegeMajorBatch.filter(filter_params).order(updated_at: :desc))
  end

  def new
    @batch = authorize CollegeMajorBatch.new
  end

  def create
    authorize CollegeMajorBatch, :create?

    if file = params[:college_major_batch][:file].presence
      @batch = Spreadsheets::CollegeMajorBatchSpreadsheet.new.import(file)

      render :wizard_review, status: :see_other
    else
      create_college_major_batch
    end
  end

  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to college_major_importers_url, notice: "Job batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_batch
      @batch = authorize CollegeMajorBatch.find_by(code: params[:code])
    end

    def create_college_major_batch
      @batch = CollegeMajorBatch.new(college_major_batch_params)

      if @batch.save
        redirect_to college_majors_url, notice: I18n.t("shared.import_success", count: @batch.college_majors.length)
      else
        redirect_to new_college_major_importer_url, alert: I18n.t("shared.some_invalid_records")
      end
    end

    def college_major_batch_params
      params.require(:college_major_batch).permit(
        :code, :total_count, :valid_count, :new_count, :reference_cache,
        importing_college_majors_attributes: [
          :college_major_id,
          college_major_attributes: [
            :id, :code, :name, :personality_type,
            :general_info, :orien_orientation_subjects, :orien_study_condition,
            :orien_graduation_condition, :curriculum, :teaching_and_learning_process,
            :gain_knowledge, :worthy_career, :recommendation
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
