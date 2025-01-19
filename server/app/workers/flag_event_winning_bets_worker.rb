
class FlagEventWinningBetsWorker
  include Sidekiq::Worker
  queue_as :leaderboard

  def perform(event_id)
    # winning_placements = EventWinningBets.call(event_id)
    # winning_placements.update_all(won: true)
    # winners_ids = winning_placements.pluck(:user_id)

    # users_amount = User.include(:bet_placements).where(
    #   id: winners_ids, bet_placements: { won: true }
    # ).sum(:bet_placements_cashback).pluck(:id, :username, :bet_placements_cashback)
    $redis.publish("new_winners_total_amount", [{ user: "users_amount", amount: 50 }].to_json)
  end
end