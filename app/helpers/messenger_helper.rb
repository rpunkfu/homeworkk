module MessengerHelper

	def checkFacebookToken
		if params["hub.verify_token"] == "123456789"
    	render text: params['hub.challenge'], status: 200
  	else
    	render text: 'ahhhhhhh, error' and return
  	end
	end

end

# 134381003642835