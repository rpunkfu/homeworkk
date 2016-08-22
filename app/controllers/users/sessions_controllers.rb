class Users::SessionsController < Devise::SessionsController
  def new
  	$conversation_id = params[:conversation_id] if !params[:conversation_id].nil?
  end
end