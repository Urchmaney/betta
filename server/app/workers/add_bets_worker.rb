class AddBetsWorker
  include Sidekiq::Worker

  def perform(*args)
    bets = JSON.parse(args[0])
    
    bets.each do |bet|
      game = Game.find_by(external_id: bet["gameId"])
      next if game.nil?

      user = User.find_by(external_id: bet["userId"])
      d_bet = Bet.find_or_create_by(external_id: bet["id"]) do |b|
        b.game = game
        b.bet_type = bet["betType"]
        b.pick = bet["pick"]
        b.odd = bet["odds"]
      end
      next if user.nil?

      BetPlacement.create(user: user, bet: d_bet, amount: bet["amount"])
    end
  end
end