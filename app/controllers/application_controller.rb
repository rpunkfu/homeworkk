class ApplicationController < ActionController::Base
	before_filter :strip_www

	def strip_www
    if request.env["HTTP_HOST"] == "www.christopherbot.co"
      redirect_to "http://christopherbot.co/"
    end
	end_time

  protected
  def set_user_api_token
    RequestStore.store[:my_api_token] = current_user.api_token # or something similar based on `session`
  end
end
