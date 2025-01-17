class AddGamesWorker
  include Sidekiq::Worker

  def perform(*args)
    games = JSON.parse(args[0])
    Game.create(
      games.map do |game|
        {
          external_id: game['gameId'],
          home_team: game['homeTeam'],
          away_team: game['awayTeam'],
          home_score: game['homeScore'],
          away_score: game['awayScore'],
          time_elapsed: game['timeElapsed'],
          events_attributes: game['events'].map do |event|
            {
              event_type: event['type'],
              for_home: event['team'] == 'home',
              player: event['player'],
              minute: event['minute']
            }
          end
        }

      end
    )
  end
end