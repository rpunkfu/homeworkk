class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location
=begin
  def store_location
	  # store last url as long as it isn't a /users path
	  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
	end
=end

	def after_sign_up_path_for(resource)
    root_path 
    return request.env['omniauth.origin'] || session[:return_to] 
  end 

  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || session[:return_to]
  end

  protected
  def set_user_api_token
    RequestStore.store[:my_api_token] = current_user.api_token # or something similar based on `session`
  end

end
