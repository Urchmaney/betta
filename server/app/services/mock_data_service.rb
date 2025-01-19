class MockDataService < ApplicationService
  def call
    load_data
    generate_games
    generate_users
    generate_bets
  end

  private

  def load_data
    @data = YAML.load_file('config/mock.yml')
  end

  def generate_games
    games = @data["games"]
    games.map do |game|
      Game.find_or_create_by(external_id: game['gameId']) do |g|
        g.home_team = game['homeTeam']
        g.away_team = game['awayTeam']
        g.home_score = game['homeScore']
        g.away_score = game['awayScore']
        g.time_elapsed = game['timeElapsed']
        g.events_attributes = game['events'].map do |event|
          {
            event_type: event['type'],
            for_home: event['team'] == 'home',
            player: event['player'],
            minute: event['minute']
          }
        end
      end
    end
  end

  def generate_users
    users = @data["users"]
    users.map do |user|
      User.find_or_create_by(external_id: user['id']) do |u|
        u.username = user['username']
        u.balance = user['balance']
        u.email = Faker::Internet.email
        u.password = "Secret1*3*5*##"
      end
    end
  end

  def generate_bets
    bets = @data["bets"]
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