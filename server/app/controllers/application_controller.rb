class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_current_request_details
  before_action :authenticate

  def catch_user_exception(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  private
    def authenticate
      if session_record = authenticate_with_http_token { |token, _| session_from_token(token) }
        Current.session = session_record
      else
        request_http_token_authentication
      end
    end

    def session_from_token(token)
      data = JWT.decode(token, ENV.fetch("APP_SECRET", Rails.application.secret_key_base), true)[0]
      Session.find(data["session_id"])
    rescue
      render json: { error: "Invalid Detail" }, status: :unauthorized
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end
end
