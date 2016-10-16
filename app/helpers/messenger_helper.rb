module MessengerHelper

	def checkFacebookToken
		$verify_token = params["hub.verify_token"]
		puts 'verify_token' + $verify_token if !$verify_token.nil?
		if $verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	redirect_to new_group_path
  	end
	end

end

# 134381003642835