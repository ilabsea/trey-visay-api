# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_account!
  before_action :set_locale

  layout :set_layout

  def pundit_user
    current_account
  end

  private
    def set_locale
      I18n.locale = current_account.try(:locale).presence || I18n.default_locale
    end

    def set_layout
      devise_controller? ? "layouts/minimal" : "layouts/application"
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
        if username == ENV["HTTP_BASIC_USER"] && password == ENV["HTTP_BASIC_PASSWORD"]
          true
        else
          head :forbidden
        end
      end
    end

    def set_request_header
      headers["Access-Control-Allow-Origin"] = "*"
    end

    def render_json(object, options = {})
      options = options.merge(text: object.to_json_oj, content_type: "application/json")
      render options
    end

    def user_not_authorized
      policy_name = exception.policy.class.to_s.underscore

      flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
      redirect_back(fallback_location: root_path)
    end
end
