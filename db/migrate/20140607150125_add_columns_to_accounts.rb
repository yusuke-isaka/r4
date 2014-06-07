class AddColumnsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :provider, :string
    add_column :accounts, :uid, :string
  end
end
