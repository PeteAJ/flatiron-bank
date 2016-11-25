class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :balance
      t.boolean :overdraft_protection, :default => false

      t.timestamps
    end
  end
end
