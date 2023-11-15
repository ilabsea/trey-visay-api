# frozen_string_literal: true

class UserDeleteInformationsController < ActionController::Base
  layout "layouts/minimal"

  def show
    @user = User.new
  end

  def destroy
    @user = User.find_for_archive(user_params)

    if @user.persisted? && @user.destroy
      redirect_to user_delete_information_url, notice: t("user.delete_info_success")
    else
      flash.now[:alert] = t("user.invalid_info")
      render :show
    end
  end

  private
    def user_params
      params.require(:user).permit(:uuid, :full_name)
    end
end
