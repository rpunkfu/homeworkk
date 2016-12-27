class Users::SessionsController < Devise::SessionsController
  def new
  	if params.to_a[0][0] == "conversation_id" 
	 		$conversation_id = params.to_a[0][1] 
 		else 
			$conversation_id = nil 
 		end 
  end
end