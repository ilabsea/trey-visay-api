# frozen_string_literal: true

class JobsController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @jobs = pagy(authorize Job.filter(filter_params))
      }

      format.xlsx {
        @jobs = authorize Job.filter(filter_params)

        if @jobs.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i
          flash[:alert] = t("shared.file_size_is_too_big", max_record: ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i)
          redirect_to jobs_url
        else
          render xlsx: "index", filename: "jobs_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @jobs = authorize Job.filter(filter_params)

        render json: @jobs
      }
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  private
    def filter_params
      params.permit(:name, :job_cluster_id)
    end
end
