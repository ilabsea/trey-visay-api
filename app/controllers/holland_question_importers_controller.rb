# frozen_string_literal: true

class HollandQuestionImportersController < ApplicationController
  before_action :set_batch, only: [:edit, :update, :destroy]

  def index
    @pagy, @batches = pagy(authorize HollandQuestionBatch.filter(filter_params).order(updated_at: :desc).includes(:holland_questions))
  end

  def new
    @batch = authorize HollandQuestionBatch.new
  end

  def create
    authorize HollandQuestionBatch, :create?

    if file = params[:holland_question_batch][:file].presence
      @batch = Spreadsheets::HollandQuestionBatchSpreadsheet.new.import(file)

      render :wizard_review, status: :see_other
    else
      create_holland_question_batch
    end
  end

  def destroy
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to holland_question_importers_url, notice: "Holland question batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_batch
      @batch = authorize HollandQuestionBatch.find_by(code: params[:code])
    end

    def create_holland_question_batch
      @batch = HollandQuestionBatch.new(holland_question_batch_params)

      if @batch.save
        redirect_to holland_questions_url, notice: I18n.t("shared.import_success", count: @batch.holland_questions.length)
      else
        redirect_to new_holland_question_importer_url, alert: I18n.t("shared.some_invalid_records")
      end
    end

    def holland_question_batch_params
      params.require(:holland_question_batch).permit(
        :code, :total_count, :valid_count, :new_count, :reference_cache,
        importing_holland_questions_attributes: [
          :holland_question_id,
          holland_question_attributes: [
            :id, :code, :name, :personality_type
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
