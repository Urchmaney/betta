class AddBalanceToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :balance, :decimal, default: 500
  end
end
