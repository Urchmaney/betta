class Bet < ApplicationRecord
  enum bet_type: {
    winner: 0,
    score_exact: 1
  }

  belongs_to :game
end
