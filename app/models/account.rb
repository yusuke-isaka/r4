class Account < ActiveRecord::Base
  TYPE_ADMIN = 1
  TYPE_USER = 2
  devise :database_authenticatable, 
         :registerable,
         :validatable
  
  validates :email, :encrypted_password, :account_type_master_id, :presence => true
  validates :account_type_master_id, :inclusion => [TYPE_ADMIN, TYPE_USER]
  
  def is_admin?
    self.account_type_master_id == 1
  end
  def is_user?
    self.account_type_master_id == 2
  end

end
