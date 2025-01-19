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
    AddGamesWorker.perform_sync(@data["games"].to_json)
  end

  def generate_users
    AddUsersWorker.perform_sync(@data["users"].to_json)
  end

  def generate_bets
    AddBetsWorker.perform_sync(@data["bets"].to_json)
  end
end