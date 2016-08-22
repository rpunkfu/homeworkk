class Users::SessionsController < Devise::SessionsController
  def new
  	param1 = params[:conversation_id] if !params[:conversation_id].nil?
  	if user_signed_in?
    	redirect_to root_url(param1)
  	end
  end
end