module MessengerHelper

	def checkFacebookToken
		logger.debug params["hub.verify_token"]
		if params["hub.verify_token"] == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: 'ahhhhhhh, error' and return
    	puts params["hub.verify_token"]
  	end
	end

end

# 134381003642835