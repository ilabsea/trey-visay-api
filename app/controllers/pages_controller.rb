# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authorize_page, only: [:edit, :update, :destroy]

  def index
    @pages = authorize Page.filter(filter_params).includes(:children)
  end

  def new
    @page = authorize Page.new
  end

  def create
    @page = authorize Page.new(page_params)

    if @page.save
      redirect_to pages_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to pages_url
    else
      render :edit
    end
  end

  def destroy
    @page.destroy

    redirect_to pages_url
  end

  private
    def filter_params
      params.permit(:name)
    end
    helper_method :filter_params

    def page_params
      params.require(:page).permit(:code, :name_km, :name_en, :parent_id)
    end

    def authorize_page
      @page = authorize Page.find(params[:id])
    end
end
