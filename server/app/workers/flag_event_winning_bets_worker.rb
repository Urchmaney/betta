
class FlagEventWinningBetsWorker
  include Sidekiq::Worker
  queue_as :leaderboard

  def perform(event_id)
    Rails.logger.info("Processing All Winning Bet Placements from Event #{event_id}")
    winning_placements = EventWinningBets.call(event_id)
    return if winning_placements.nil?

    winning_placements.update_all(won: true)
  end
end