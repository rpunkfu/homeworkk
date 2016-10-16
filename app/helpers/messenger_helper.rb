module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		puts "params inspect " + params.inspect
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params.inspect + verify_token
  	end
	end

end

# 134381003642835