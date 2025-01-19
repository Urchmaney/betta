class Bet < ApplicationRecord
  belongs_to :game
  has_many :bet_placements

  validates :odd, numericality: {greater_than: 0}
end
