# frozen_string_literal: true

class MiddleSchoolImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_model
      Batches::MiddleSchoolBatch
    end

    def redirect_success_url
      middle_schools_url
    end

    def redirect_error_url
      new_middle_school_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name, :commune_id ]
    end
end
