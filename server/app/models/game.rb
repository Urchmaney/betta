class Game < ApplicationRecord
  has_many :events
  has_many :bets

  accepts_nested_attributes_for :events
end
