class BetPlacement < ApplicationRecord
    belongs_to :user
    belongs_to :bet

    validates :amount, numericality: {greater_than: 0}
    validates :odd, numericality: {greater_than: 0}

    before_create :deduct_balance, :calculate_cash_back

    delegate :game, to: :bet

    private

    def deduct_balance
      self.user.balance = self.user.balance - self.amount
      throw :abort if self.user.balance < 0

      self.user.save
    end

    def calculate_cash_back
        self.cash_back = self.amount * self.bet.odd
    end
end