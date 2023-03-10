# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[ edit update archive resend_confirmation]

  def index
    @pagy, @accounts = pagy(policy_scope(authorize Account.filter(filter_params).includes(:counselor_school)))
  end

  def show
    @account = authorize Account.with_deleted.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def new
    @account = authorize Account.new
  end

  def create
    @account = authorize Account.new(account_params)

    if @account.save
      redirect_to accounts_url, notice: "Account was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_url, notice: "Account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @account.destroy

    redirect_to accounts_url, status: :see_other, notice: I18n.t("account.archive_successfully", email: @account.email)
  end

  def restore
    @account = authorize Account.only_deleted.find(params[:id])
    @account.restore

    redirect_to accounts_url, notice: I18n.t("account.restore_successfully", email: @account.email)
  end

  def destroy
    @account = authorize Account.only_deleted.find(params[:id])
    @account.really_destroy!

    redirect_to accounts_url(archived: true)
  end

  def resend_confirmation
    @account.send_confirmation_instructions

    redirect_to accounts_url, notice: I18n.t("account.resend_confirmation_successfully")
  end

  private
    def set_account
      @account = authorize Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:email, :role, :counselor_school_id)
    end

    def filter_params
      params.permit(:email, :archived)
    end
end
