class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def home
 		#Messagehuman.message("134381003642835", "Sign up" + <a href='https://christopherbot.herokuapp.com'>here</a> )
  end
  
end
