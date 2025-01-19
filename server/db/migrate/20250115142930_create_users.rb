class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :external_id, null: true, index: { unique: true }
      t.string :username,      null: false
      t.string :email,           null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.decimal :balance, default: 150
      t.boolean :verified, null: false, default: false
      t.check_constraint "balance >= 0" 

      t.timestamps
    end
  end
end
