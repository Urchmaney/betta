class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      @session = user.sessions.create!
      token = JWT.encode(
        {session_id: @session.id},
        ENV.fetch("APP_SECRET", Rails.application.secret_key_base),
        'HS256'
      )
      response.set_header "X-Session-Token", token

      render json: @session, status: :created
    else
      render json: { error: "That email or password is incorrect" }, status: :unauthorized
    end
  end

  def destroy
    @session.destroy
  end

  private
    def set_session
      @session = Current.user.sessions.find(params[:id])
    end
end
