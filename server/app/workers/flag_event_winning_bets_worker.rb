
class FlagEventWinningBetsWorker
  include Sidekiq::Worker
  queue_as :leaderboard

  def perform(event_id)
    winning_placements = EventWinningBets.call(event_id)
    return if winning_placements.nil?
  
    winners_ids = winning_placements.pluck(:user_id).uniq
    winning_placements.update_all(won: true)

    users_amount = User.joins(:bet_placements).where(id: winners_ids, bet_placements: { won: true }).group(
      :id, :username).sum("bet_placements.cashback").collect {|k, v| { id: k[0], username: k[1], amount: v} }

    $redis.publish("new_winners_total_amount", users_amount.to_json)
  end
end