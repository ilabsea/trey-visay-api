# frozen_string_literal: true

class CareerWebsitesController < ApplicationController
  before_action :authorize_career_website, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @pagy, @career_websites = pagy(authorize CareerWebsite.filter(filter_params))
      }

      format.xlsx {
        @career_websites = authorize CareerWebsite.filter(filter_params)

        if @career_websites.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to career_websites_url
        else
          render xlsx: "index", filename: "career_websites_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }

      format.json {
        @career_websites = authorize CareerWebsite.filter(filter_params)

        render json: @career_websites
      }
    end
  end

  def new
    @career_website = authorize CareerWebsite.new
  end

  def create
    @career_website = authorize CareerWebsite.new(career_website_params)

    if @career_website.save
      redirect_to career_websites_url, notice: "Career website was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @career_website.update(career_website_params)
      redirect_to career_websites_url, notice: "Career website was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @career_website.destroy

    redirect_to career_websites_url, status: :see_other, notice: "Career website was destroyed successfully"
  end

  private
    def filter_params
      params.permit(:name)
    end
    helper_method :filter_params

    def authorize_career_website
      @career_website = authorize CareerWebsite.find(params[:id])
    end

    def career_website_params
      params.require(:career_website).permit(:id, :name, :url, :description, :logo, :remove_logo)
    end
end
