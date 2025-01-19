class Event < ApplicationRecord
  belongs_to :game

  validates :event_type, presence: true
  validates :minute, numericality: { in: 1..120 }

  after_create :check_event_winning_bets

  def check_event_winning_bets
    FlagEventWinningBetsWorker.perform_async(id)
  end
end
