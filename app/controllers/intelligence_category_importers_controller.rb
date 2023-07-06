# frozen_string_literal: true

class IntelligenceCategoryImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "IntelligenceCategoryBatch"
    end

    def redirect_success_url
      intelligence_categories_url
    end

    def redirect_error_url
      new_intelligence_category_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name_km, :name_en, :description, :appropriate_learning_method, :suitable_job ]
    end
end
