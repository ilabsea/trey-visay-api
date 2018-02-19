class Api::V1::SessionsController < Devise::SessionsController
  before_action :check_params, :login_attempt, only: :create
  skip_before_action :require_no_authentication
  skip_before_action :verify_authenticity_token
  
  ERRORS = {
    invalid: 'Error with your login or password.',
    invalid_token: 'Invalid authentication token.',
    unconfirmed: 'You have to confirm your account before continuing.'
  }

  def create
    render json: { success: true, auth_token: self.resource.authentication_token }, status: :created
  end

  def destroy
    account = Account.find_by_authentication_token params[:auth_token]
    sign_out current_account
    return invalid_attempt :invalid_token, :not_found unless account

    render json: { success: account.reset_authentication_token! }, status: :no_content
  end

  def refresh_token
    render json: { success: true, auth_token: self.resource.refresh_authentication_token }, status: :created
  end

  protected
    def login_attempt
      self.resource = Account.find_for_database_authentication email: params[:account][:email]
      return invalid_attempt :invalid, :unauthorized unless resource
      return invalid_attempt :unconfirmed, :unauthorized unless resource.active_for_authentication?
      return invalid_attempt :invalid, :unauthorized unless resource.valid_password? params[:account][:password]
    end

    def check_params
      return invalid_attempt :invalid, :unauthorized unless params[:account]
    end

    def invalid_attempt reason, status
      warden.custom_failure!
      render json: { success: false, message: ERRORS[reason] }, status: status
    end
end

