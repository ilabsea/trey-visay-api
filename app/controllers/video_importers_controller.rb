# frozen_string_literal: true

class VideoImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_model
      Batches::VideoBatch
    end

    def itemables_url
      videos_url
    end

    def new_importer_url
      new_video_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name, :url, :author ]
    end
end
