module MessengerHelper
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def sendMessage
  	Messenger::Client.send(
      Messenger::Request.new(
        Messenger::Elements::Text.new(text: "how you doin"),
        134381003642835
      )
    )
  end

end
