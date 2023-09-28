# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authorize_video, only: [:edit, :update, :destroy]

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

    def new
      @video = authorize Video.new
    end

    def create
      @video = authorize Video.new(video_params)

      if @video.save
        redirect_to videos_url, notice: "Video was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @video.update(video_params)
        redirect_to videos_url, notice: "Video was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @video.destroy

      redirect_to videos_url, notice: "Video was destroyed successfully"
    end
  end

  private
    def filter_params
      params.permit(:name)
    end
    helper_method :filter_params

    def authorize_video
      @video = authorize Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:code, :name, :url, :author)
    end
end
