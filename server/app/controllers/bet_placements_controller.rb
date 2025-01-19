class BetPlacementsController < ApplicationController

  rescue_from 'ActionController::ParameterMissing', with: :catch_user_exception
  rescue_from 'ActiveRecord::RecordInvalid', with: :catch_user_exception

  def create
    result = Bet.transaction do
      Current.user.bet_placements.create(bet_placements_params)
    end
    if result
      Rails.cache.delete("leaderboard")
      render json: result, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def index
    render json: Current.user.bet_placements, status: :ok
  end

  private
    def bet_placements_params
      params.permit(bet_placements: [[:bet_id, :amount]]).require(:bet_placements)
    end
end
