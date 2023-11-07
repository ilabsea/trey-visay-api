# frozen_string_literal: true

class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :http_basic_authentication

  around_action :rescue_with_check_api_docs

  def rescue_with_check_api_docs
    yield
  rescue StandardError => ex
    Rails.logger.info ex.message
    Rails.logger.info ex.backtrace.join("\n")

    if ex.is_a?(ActiveRecord::RecordNotFound)
      render_error_response_422(ex.message)
    else
      render_generic_error_response(ex.message)
    end
  end

  def render_generic_error_response(message = "", error_code = 1)
    render_json({ message: api_error_message(message), error_code: error_code }, status: 400)
  end

  def render_error_response_422(message = "Unprocessable Entity")
    render_json({ message: api_error_message(message), error_code: 2, error_object: message }, status: 422)
  end

  def render_error_response_403(message = "Forbidden")
    render_json({ message: api_error_message(message), error_code: 3 }, status: 403)
  end

  def render_error_response_409(message = "Conflict")
    render_json({ message: api_error_message(message), error_code: 4 }, status: 409)
  end

  def forbidden_response
    render_error_response_403
  end

  def api_error_message(message)
    check_api_text = "Check the API documentation: https://github.com/ilabsea/trey-visay-api"
    "#{message} - #{check_api_text}"
  end

  private
    def http_basic_authentication
      authenticate_or_request_with_http_basic do |username, password|
        if username == ENV["HTTP_BASIC_USER"] && password == ENV["HTTP_BASIC_PASSWORD"]
          true
        else
          head :forbidden
        end
      end
    end
end
