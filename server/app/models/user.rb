class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :bet_placements, dependent: :destroy
  has_many :winning_bet_placements, -> { where(won: true) }, class_name: "BetPlacement"

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }
  validates :username, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0, message: "Low for transaction." }

  scope :leader_board, lambda {
    Rails.cache.fetch("leaderboard") do
      includes(:winning_bet_placements).group(:id, :username).order(
        'sum_bet_placements_cashback DESC').sum("bet_placements.cashback").collect{|k, v| {name: k[1], id: k[0], total: v }}
    end
  }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  def total_wins
    bet_placements.where(won: true).sum(:cashback)
  end
end
