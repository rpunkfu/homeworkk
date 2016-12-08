class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :groups
  
  accepts_nested_attributes_for :groups

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.new_from_omniauth(auth, conversation_id)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.first_name
      user.provider = auth.provider
      user.uid = auth.uid
      user.conversation_id = conversation_id.to_s
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.first_name
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.first_name = data["first_name"] if user.first_name.blank?
        user.password = Devise.friendly_token[0,20]
        user.provider = data["provider"]
        user.uid = data["uid"]
    end
  end
end

end