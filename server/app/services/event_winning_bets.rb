class EventWinningBets < ApplicationService
  attr_reader :event_id

  def initialize(event_id)
    @event_id = event_id
  end

  def call
    event
    winning_bets
    winning_placements
  end

  private

  def event
    @event = Event.find(event_id)
  end

  def winning_bets
    if event.yellowCard
      @bet_ids = Bet.where(bet_type: "1-yelloCard", won: false).pluck(:id)
    end
  end

  def winning_placements
    BetPlacement.where(id: @bet_ids)
  end
end