# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[edit update archive resend_confirmation enable_dashboard disable_dashboard]

  def index
    @pagy, @accounts = pagy(policy_scope(authorize Account.filter(filter_params).includes(:high_schools)))
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

  def enable_dashboard
    @account.add_to_grafana_async

    redirect_to accounts_url, notice: I18n.t("account.enable_dashboard_successfully", email: @account.email)
  end

  def disable_dashboard
    @account.remove_from_grafana_async

    redirect_to accounts_url, notice: I18n.t("account.disable_dashboard_successfully", email: @account.email)
  end

  private
    def set_account
      @account = authorize Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:email, :first_name, :last_name, :phone_number, :role, :province_id, :district_id, high_school_ids: [], province_ids: [])
    end

    def filter_params
      params.permit(:email, :role, :archived, :province_id, :district_id, :high_school_code)
    end
end
