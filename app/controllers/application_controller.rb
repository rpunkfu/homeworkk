class ApplicationController < ActionController::Base

  protected
  def set_user_api_token
    RequestStore.store[:my_api_token] = current_user.api_token # or something similar based on `session`
  end

  def redirectCB(url)
  	if url == "http://christopherbot.herokuapp.com/users/sign_in" || url == "https://christopherbot.herokuapp.com/users/sign_in"
  		redirect_to "https://www.christopherbot.co/users/sign_in/"
  	end
  end
  helper_method :redirectCB
end
