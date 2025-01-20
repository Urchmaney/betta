class LiveEventWorker
  include Sidekiq::Worker

  def perform(*args)
    games = JSON.parse(args[0])
    games.map do |game|
      Rails.logger.info("Processing Game Event of Game with Id of #{game['gameId']}")
      created = false
      found_game = Game.find_or_create_by(external_id: game['gameId']) do |g|
        created = true
        g.home_team = game['homeTeam']
        g.away_team = game['awayTeam']
        g.home_score = game['homeScore']
        g.away_score = game['awayScore']
        g.time_elapsed = game['timeElapsed']
      end

      if !created
        found_game.home_score = game['homeScore'] if game['homeScore'].present?
        found_game.away_score = game['awayScore'] if game['awayScore'].present?
        found_game.time_elapsed = game['timeElapsed'] if game['timeElapsed'].present?

        found_game.save
      end

      found_game.events.create(
        game['events'].map do |event|
          {
            event_type: event['type'],
            for_home: event['team'] == 'home',
            player: event['player'],
            minute: event['minute']
          }
        end
      )
    end
  end
end