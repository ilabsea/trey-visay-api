# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(policy_scope(User.filter(filter_params).order(created_at: :desc).includes(:games, :personal_understandings, :high_school, :holland_quizzes)))
  end

  def download
    @users = User.filter(params).includes(games: :personal_understandings)

    if @users.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i then
      flash[:alert] = "The file size is too big, please filter it!"
      redirect_to users_url
    else
      send_data(::AssessmentResultService.new(@users).zip_data, type: "application/zip", filename: "assessment_result.zip")
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def filter_params
      params.permit(:province_id, :district_id, :high_school_code, :grade)
    end
end
