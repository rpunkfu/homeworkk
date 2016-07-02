class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def home
  	#@messageHuman = Messagehuman.data
  	@user_data = request.env["omniauth.auth"]
  end
  
end
