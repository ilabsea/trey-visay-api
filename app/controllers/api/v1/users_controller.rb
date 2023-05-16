# frozen_string_literal: true

class Api::V1::UsersController < ApiController
  def create
    params["data"] = JSON.parse(params["data"])
    @user = User.find_or_initialize_by(uuid: params["data"]["uuid"])

    if @user.update_attributes(filter_params)
      @user.remove_photo! if params[:photo].blank?
      @user.save!

      render json: { success: true }
    else
      Log.create(user: params["data"], version: params["data"]["version"])
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  def me
    authenticate_or_request_with_http_basic do |username, password|
      if username == ENV["HTTP_BASIC_USER"] && password == ENV["HTTP_BASIC_PASSWORD"]
        render json: { success: true }
      end
    end
  end

  private
    def filter_params
      params.require(:data).permit(
        :id, :full_name, :password, :username, :sex, :date_of_birth, :phone_number,
        :grade, :high_school_code, :province_code, :district_code, :commune_code
      ).merge(photo: params[:photo])
    end
end
