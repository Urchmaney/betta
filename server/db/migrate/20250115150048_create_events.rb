class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|      
      t.references :game, null: false, foreign_key: true
      t.string :event_type, null: false
      t.boolean :for_home
      t.string :player
      t.integer :minute, null: false

      t.timestamps
    end
  end
end
