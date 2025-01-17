
class UsersController < ApplicationController
  skip_before_action :authenticate
  
  def leaderboard
    render json: User.leader_board, status: :ok
  end
end