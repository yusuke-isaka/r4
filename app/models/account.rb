class Account < ActiveRecord::Base
  TYPE_ADMIN = 1
  TYPE_USER = 2
  devise :database_authenticatable, 
         :registerable,
         :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  validates :email, :encrypted_password, :account_type_master_id, :presence => true
  validates :account_type_master_id, :inclusion => [TYPE_ADMIN, TYPE_USER]
  
  def is_admin?
    self.account_type_master_id == 1
  end
  def is_user?
    self.account_type_master_id == 2
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

end
