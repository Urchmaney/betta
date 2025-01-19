class EventWinningBets < ApplicationService
  attr_reader :event_id, :event

  def initialize(event_id)
    @event_id = event_id
  end

  def call
    event
    winning_placements
  end

  private

  def event
    @event = Event.find(event_id)
  end

  # Uses the event.event_type column value to call methods.
  # These means if we have an event
  # 
  # <Event id:4 event_type: "goal" />
  # 
  # Then for this service to get all winning placements, we need to define the method "goal"
  # 
  # def goal
  #   ....
  # end
  # 
  # All methods should return #<ActiveRecord::Relation []> or nil
  # 
  def winning_placements
    event_method = @event.event_type.underscore.to_sym
    return send event_method if respond_to?(event_method, true)

    nil
  end

  def yellow_card
    pick = @event.for_home ? "home" : "away"
    @bet_ids = Bet.where(bet_type: "oneYelloCard", game_id: @event.game_id, pick: pick).pluck(:id)
    BetPlacement.where(bet_id: @bet_ids, won: false)
  end

  def full_time
    game = event.game
    if game.home_score == game.away_score
      @bet_ids = Bet.where(bet_type: "scoreExact", game_id: @event.game_id, pick: "#{game.home_score}-#{game.away_score}").pluck(:id)
    else
      pick = game.home_score > game.away_score ? "home" : "away"
      @bet_ids = Bet.where(bet_type: "winner", game_id: @event.game_id, pick: pick).or(
        Bet.where(bet_type: "scoreExact", game_id: @event.game_id, pick: "#{game.home_score}-#{game.away_score}")
      ).pluck(:id)
    end
    BetPlacement.where(bet_id: @bet_ids, won: false)
  end
end