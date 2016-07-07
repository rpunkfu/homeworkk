class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]
        
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a first_name
    end 
  end 
end