class Bet < ApplicationRecord
  enum bet_type: {
    winner: 0,
    score_exact: 1
  }

  belongs_to :game
  belongs_to :user
  before_create :set_odd, :deduct_balance
  before_update :throw_if_odd_changes

  private

  def set_odd
    self.odd = Random.rand(50) / 10.0
  end

  def deduct_balance
    self.user.balance = self.user.balance - self.amount
  end

  def throw_if_odd_changes
    throw "Changing Odds" if odd_changed?
  end
end
