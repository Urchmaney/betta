class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      @session = user.sessions.create!
      response.set_header "X-Session-Token", @session.signed_id

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
