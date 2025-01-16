class CreateGame < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :game_id, null: false, index: { unique: true }
      t.string :home_team
      t.string :away_team
      t.integer :away_score, default: 0
      t.integer :home_score, default: 0
      t.integer :timeElapsed, limit: 120, default: 0

      t.timestamps
    end
  end
end
