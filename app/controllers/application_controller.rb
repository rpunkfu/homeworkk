class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def set_user_api_token
    RequestStore.store[:my_api_token] = current_user.api_token # or something similar based on `session`
  end

  def sendUserMessage(text, user)
		Messenger::Client.send(
  		Messenger::Request.new(
    		Messenger::Elements::Text.new(text: text),
    		user
  		)
		)
	end
end
