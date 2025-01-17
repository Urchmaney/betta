class BetPlacement < ApplicationRecord
    belongs_to :user
    belongs_to :bet

    before_create :deduct_balance

    delegate :goal, to: :bet

    private

    def deduct_balance
      self.user.balance = self.user.balance - self.amount
    end
end