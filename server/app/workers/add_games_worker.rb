class AddGamesWorker
  include Sidekiq::Worker

  def perform(*args)
    games = JSON.parse(args[0])
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
end