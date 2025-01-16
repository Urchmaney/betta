class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :bet_type, null: false
      t.string :pick, null: false
      t.integer :amount, null: false
      t.float :odd, null: false

      t.timestamps
    end
  end
end
