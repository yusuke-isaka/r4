class AddDeviseToAccounts < ActiveRecord::Migration
  def change
    create_table(:accounts) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.integer :account_type_master_id,    :null=>false
      t.integer :created_by         
      t.integer :updated_by
      t.integer :lock_version, :default=>0, :null=>false         
      t.timestamps
    end
    Account.create!(:email => "admin@funny.jp.net", :password => "admin", :account_type_master_id => Account::TYPE_ADMIN,
      :created_by => 1, :updated_by => 1 )
  end

end
