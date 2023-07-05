# frozen_string_literal: true

class JobClustersController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @job_clusters = pagy(authorize JobCluster.filter(filter_params).includes(:videos))
      }

      format.xlsx {
        @job_clusters = authorize JobCluster.filter(filter_params).includes(:videos)

        if @job_clusters.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to job_cluster_url
        else
          render xlsx: "index", filename: "job_cluster_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @job_clusters = authorize JobCluster.filter(filter_params).includes(:videos)

        render json: @job_clusters
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
end
