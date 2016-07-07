class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]
        
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end 
end