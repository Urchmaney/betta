class BetsController < ApplicationController

  rescue_from 'ActionController::ParameterMissing', with: :catch_user_exception
  rescue_from 'ActiveRecord::RecordInvalid', with: :catch_user_exception

  def create
    result = Bet.transaction do
      Current.user.bets.create(bets_params)
      Current.user.save!
    end
    if result
      Rails.cache.delete("leaderboard")
      render json: result, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def index
    render json: Current.user.bets, status: :ok
  end

  private
    def bets_params
      params.permit(bets: [[:game_id, :bet_type, :pick, :amount]]).require(:bets)
    end
end
