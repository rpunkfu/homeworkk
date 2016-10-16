module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		puts "params 3 inspect " + params["hub.challenger"].inspect
		puts "params 4 inspect " + params["hub.verify_token"].inspect
		puts "params hub.mode " + params["hub.mode"]
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params.inspect + verify_token.inspect
  	end
	end

end

# 134381003642835