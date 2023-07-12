# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :filter_params

  def index
    respond_to do |format|
      format.html {
        @pagy, @users = pagy(policy_scope(User.filter(filter_params).order(created_at: :desc).includes(:games, :personal_understandings, :high_school)))
      }

      format.xlsx {
        @users = policy_scope(User.filter(filter_params))

        if @users.length > Settings.max_download_record
          flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
          redirect_to users_url
        else
          render xlsx: "index", filename: "users_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xlsx"
        end
      }
    end
  end

  def download
    @users = User.filter(params).includes(games: :personal_understandings)

    if @users.length > Settings.max_download_record then
      flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
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
