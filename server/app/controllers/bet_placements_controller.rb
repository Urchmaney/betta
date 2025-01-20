class BetPlacementsController < ApplicationController

  rescue_from 'ActionController::ParameterMissing', with: :catch_user_exception
  rescue_from 'ActiveRecord::RecordInvalid', with: :catch_user_exception

  def create
    bet_placement = Current.user.bet_placements.new(bet_placement_params)

    if bet_placement.save
      render json: bet_placement, status: :created
    else
      render json: bet_placement.errors, status: :unprocessable_entity
    end
  end

  def index
    render json: Current.user.bet_placements, status: :ok
  end

  private
    def bet_placement_params
      params.permit(bet_placement: [:bet_id, :amount]).require(:bet_placement)
    end
end
