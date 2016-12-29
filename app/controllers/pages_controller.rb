class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def home
 		#Messagehuman.message("134381003642835", "Sign up" + <a href='https://christopherbot.herokuapp.com'>here</a> )
  end

  def talk_christopher
  end

  def commands
  end
  
  def date_picker
  end

  def redirect_home
  	redirect_to root_path, notice: 'sorry, you may not access that page.'
  end
  helper_method :redirect_home
end
