class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.date :date
      t.integer :amount
      t.text :description
      t.integer :account_balance
      t.integer :account_id
    end
  end
end
