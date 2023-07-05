# frozen_string_literal: true

class VideosController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @videos = pagy(authorize Video.filter(filter_params))
      }

      format.xlsx {
        @videos = authorize Video.filter(filter_params)

        if @videos.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to videos_url
        else
          render xlsx: "index", filename: "videos_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @videos = authorize Video.filter(filter_params)

        render json: @videos
      }
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
end
