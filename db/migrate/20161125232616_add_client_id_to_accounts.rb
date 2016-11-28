class AddClientIdToAccounts < ActiveRecord::Migration[5.0]
  def change
      add_column :accounts, :client_id, :integer
  end
end
