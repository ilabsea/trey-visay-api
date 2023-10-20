# frozen_string_literal: true

class JobClustersController < ApplicationController
  before_action :authorize_job_cluster, only: [:edit, :update, :destroy]

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

  def new
    @job_cluster = authorize JobCluster.new
  end

  def create
    @job_cluster = authorize JobCluster.new(job_cluster_params)

    if @job_cluster.save
      redirect_to job_clusters_url, notice: "Job cluster was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job_cluster.update(job_cluster_params)
      redirect_to job_clusters_url, notice: "Job cluster was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job_cluster.destroy

    redirect_to job_clusters_url, notice: "Job cluster was destroyed successfully"
  end

  private
    def filter_params
      params.permit(:name)
    end
    helper_method :filter_params

    def authorize_job_cluster
      @job_cluster = authorize JobCluster.find(params[:id])
    end

    def job_cluster_params
      params.require(:job_cluster).permit(
        :name, :recommendation, :logo, :remove_logo, video_ids: []
      )
    end
end
