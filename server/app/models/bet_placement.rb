class BetPlacement < ApplicationRecord
    belongs_to :user
    belongs_to :bet

    validates :amount, numericality: {greater_than: 0}

    before_create :deduct_balance, :calculate_cash_back

    after_update :publish_cashback, if: :saved_change_to_cashback?

    after_update :publish_new_win, :publish_total_winning, if: :saved_change_to_win?

    delegate :total_wins, to: :user

    def calculate_cash_back
      self.cashback = self.amount * self.bet.odd
    end

    private

    def deduct_balance
      self.user.balance = self.user.balance - self.amount
      throw :abort if self.user.balance < 0

      self.user.save
    end

    def publish_cashback
      $redis.publish("cashback_update", { user_id: user_id, username: user.username, cashback: cashback }.to_json)
    end

    def publish_new_win
      return unless won

      $redis.publish("new_win", { user_id: user_id, username: user.username, bet_id: bet_id, cashback: cashback }.to_json)
    end

    def publish_total_winning
      return unless won

      $redis.publish("total_win", { user_id: user_id, username: user.username, bet_id: bet_id, total_cashback: total_wins }.to_json) 
    end
end