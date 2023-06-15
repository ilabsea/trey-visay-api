# frozen_string_literal: true

module Batches::ItemableImportersConcern
  extend ActiveSupport::Concern
  included do
    before_action :set_batch, only: [:edit, :update, :destroy]

    def index
      @pagy, @batches = pagy(authorize batch_model.filter(filter_params).order(updated_at: :desc))
    end

    def new
      @batch = authorize batch_model.new
    end

    def create
      authorize batch_model, :create?

      if file = params[:batch][:file].presence
        @batch = spreadsheet_model.new.import(file)

        render :wizard_review, status: :see_other
      else
        create_batch
      end
    end

    private
      def batch_model
        raise NotImplementedError, "You must define #resolve in #{self.class}"
      end

      def itemables_url
        raise NotImplementedError, "You must define #resolve in #{self.class}"
      end

      def new_importer_url
        raise NotImplementedError, "You must define #resolve in #{self.class}"
      end

      def itemable_attributes
        raise NotImplementedError, "You must define #resolve in #{self.class}"
      end

      def spreadsheet_model
        "Spreadsheets::#{batch_model}Spreadsheet".constantize
      end

      def set_batch
        @batch = authorize batch_model.find_by(code: params[:code])
      end

      def create_batch
        @batch = authorize batch_model.new(batch_params)

        if @batch.save
          redirect_to itemables_url, notice: I18n.t("shared.import_success", count: @batch.importing_items.length)
        else
          redirect_to new_importer_url, alert: I18n.t("shared.some_invalid_records")
        end
      end

      def batch_params
        params.require(:batch).permit(
          :code, :total_count, :valid_count, :province_count, :new_count, :reference_cache,
          importing_items_attributes: [
            :itemable_id, :itemable_type,
            itemable_attributes: itemable_attributes
          ]
        ).merge({
          creator_id: current_account.id
        })
      end

      def filter_params
        params.permit(:keyword)
      end
  end
end
