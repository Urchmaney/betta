class CreateBetPlacement < ActiveRecord::Migration[7.1]
  def change
    create_table :bet_placements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bet, null: false, foreign_key: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
  