module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		puts 'verify_token' + verify_token
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params["hub.verify_token"] and return
  	end
	end

end

# 134381003642835