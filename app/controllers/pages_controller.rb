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
  	@stuff = Hash.new
  	if !params["paused_time"].nil?
  		@user = User.find_by(conversation_id: params[:conversation_id])
  		@user.update(paused_time: params["paused_time"])
  		redirect_to root_path, notice: "you are paused until then"
  	end
  end

  def redirect_home
  	redirect_to root_path, notice: 'sorry, you may not access that page.'
  end
  helper_method :redirect_home
end
