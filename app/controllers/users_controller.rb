# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_account!

  def index
    @users = User.filter(params).includes(:games, :personal_understandings).page(page_params).per(20)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
