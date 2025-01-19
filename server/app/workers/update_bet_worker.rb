class UpdateBetWorker
  include Sidekiq::Worker

  def perform(*args)
    bets = JSON.parse(args[0])
    bets.map do |b|
      Rails.logger.info("Updating Bet With external Id #{b["betId"]} to #{b["odds"]}")
      bet = Bet.find_by(external_id: b["betId"])
      next if bet.nil?

      bet.update(odd: b["odds"])
    end
  end
end