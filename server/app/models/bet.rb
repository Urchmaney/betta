class Bet < ApplicationRecord
  belongs_to :game
  has_many :bet_placements
end
