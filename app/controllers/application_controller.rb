# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :set_layout

  expose(:user)
  expose(:games) { user.games }
  expose(:users) do
    if current_account
      # public collections are accesible by all users
      # here we only need the ones in which current_user is a member
      current_account.users
    else
      User.all
    end
  end

  def set_layout
    devise_controller? ? "layouts/minimal" : "layouts/application"
  end

  def authenticate_admin_user!
    head :forbidden unless current_account.role == Account::ROLE[0]
  end

  def authenticate_api_user!
    params.delete :auth_token if current_account
    basic_authentication_check unless current_account
  end

  def basic_authentication_check
    account = Account.find_by_authentication_token(params[:auth_token])
    params.delete :auth_token

    # sign_in account
    http_basic_authentication unless account
  end

  def http_basic_authentication
    authenticate_or_request_with_http_basic do |username, password|
      if username == ENV['HTTP_BASIC_USER'] && password == ENV['HTTP_BASIC_PASSWORD']
        true
      else
        head :forbidden
      end
    end
  end

  def set_request_header
    headers['Access-Control-Allow-Origin'] = '*'
  end

  def render_json(object, options = {})
    options = options.merge(text: object.to_json_oj, content_type: 'application/json')
    render options
  end

  def page_params
    params[:page] || 1
  end

  def perpage_params
    params[:per_page] || 20
  end
end
