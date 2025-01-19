class BetPlacement < ApplicationRecord
    belongs_to :user
    belongs_to :bet

    before_create :deduct_balance

    delegate :game, to: :bet

    private

    def deduct_balance
      self.user.balance = self.user.balance - self.amount
      throw :abort if self.user.balance < 0

      self.user.save
    end
end