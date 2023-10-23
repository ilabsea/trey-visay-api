# frozen_string_literal: true

class JobClusterImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "JobClusterBatch"
    end

    def redirect_success_url
      job_clusters_url
    end

    def redirect_error_url
      new_job_cluster_importer_url
    end

    def itemable_attributes
      [ :id, :code, :name, :display_order, :logo_cache, :recommendation, cluster_videos_attributes: [:id, :video_id, :_destroy]]
    end
end
