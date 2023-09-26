# frozen_string_literal: true

class CareerWebsiteImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "CareerWebsiteBatch"
    end

    def redirect_success_url
      career_websites_url
    end

    def redirect_error_url
      new_career_website_importer_url
    end

    def itemable_attributes
      [ :id, :name, :description, :url, :logo_cache ]
    end
end
