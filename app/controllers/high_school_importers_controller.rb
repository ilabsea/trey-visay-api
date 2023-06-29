# frozen_string_literal: true

class HighSchoolImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "HighSchoolBatch"
    end

    def redirect_success_url
      high_schools_url
    end

    def redirect_error_url
      new_high_school_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name_km, :name_en, :commune_id, :district_id ]
    end
end
