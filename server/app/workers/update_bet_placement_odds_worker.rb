class UpdateBetPlacementOddsWorker
  include Sidekiq::Worker

  def perform(*args)
    Rails.logger.info("Updating all Bet Placement that belongs to Bet Id #{args[0]}")
    bet_placements = BetPlacement.where(bet_id: args[0])

    bet_placements.each do |bet_placement|
      bet_placement.calculate_cash_back
      bet_placement.save
    end
  end
end