class GameSimulation < ApplicationService
  attr_reader :game_id, :game

  def initialize(game_id)
    @game_id = game_id
  end

  def call
    return unless game_exists?

    record_event
    send_game_change
  end

  private

  def game_exists?
    @game = Game.find_by(id: game_id, timeElapsed: 0...120)
    @game.present?
  end

  def record_event
    ActiveRecord::Base.transaction do
      create_game_event
      update_game
    end
  end

  def create_game_event
    @timeElapsed = [game.timeElapsed + (Random.rand(10) * 5), 120].min
    @event_type = Event.event_types.keys.sample
    @for_home = Random.rand(2).zero?
    Event.create({
      event_type: @event_type,
      player: "Player #{Random.rand(1..12)}",
      game_id: game_id,
      for_home: @for_home,
      minute: @timeElapsed
    })
  end

  def update_game
    @game.timeElapsed = @timeElapsed
    @game.home_score = @game.home_score + 1 if @for_home && @event_type.to_sym == :goal
    @game.away_score = @game.away_score + 1 if !@for_home && @event_type.to_sym == :goal
    @game.save
  end

  def send_game_change
    Sidekiq::Client.push(queue: "game_queue", args: [1, 3], class: "Rnadome")
  end
end