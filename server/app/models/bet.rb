class Bet < ApplicationRecord
  belongs_to :game
  has_many :bet_placements

  validates :odd, numericality: {greater_than: 0}

  after_update :update_placement_cashbacks, if: :saved_change_to_odd?

  private

  def update_placement_cashbacks
    UpdateBetPlacementOddsWorker.perform_async(id)
  end
end
