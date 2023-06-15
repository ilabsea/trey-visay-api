# frozen_string_literal: true

class VideoImportersController < ApplicationController
  before_action :set_batch, only: [:edit, :update, :destroy]

  def index
    @pagy, @batches = pagy(authorize Batches::VideoBatch.filter(filter_params).order(updated_at: :desc))
  end

  def new
    @batch = authorize Batches::VideoBatch.new
  end

  def create
    authorize Batches::VideoBatch, :create?

    if file = params[:batches_video_batch][:file].presence
      @batch = Spreadsheets::VideoBatchSpreadsheet.new.import(file)

      render :wizard_review, status: :see_other
    else
      create_batch
    end
  end

  private
    def set_batch
      @batch = authorize Batches::VideoBatch.find_by(code: params[:code])
    end

    def create_batch
      @batch = authorize Batches::VideoBatch.new(batch_params)

      if @batch.save
        redirect_to videos_url, notice: I18n.t("shared.import_success", count: @batch.importing_items.length)
      else
        redirect_to new_video_importer_url, alert: I18n.t("shared.some_invalid_records")
      end
    end

    def batch_params
      params.require(:batches_video_batch).permit(
        :code, :total_count, :valid_count, :province_count, :new_count, :reference_cache,
        importing_items_attributes: [
          :itemable_id, :itemable_type,
          itemable_attributes: [
            :id, :code, :name, :url, :author
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
