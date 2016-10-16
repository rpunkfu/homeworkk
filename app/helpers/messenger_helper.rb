module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		puts "params 3 inspect " + params["hub.challenge"].to_s.inspect
		puts "params 4 inspect " + params["hub.verify_token"].to_s.inspect
		puts "params hub.mode " + params["hub.mode"].to_s.inspect
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params.inspect + verify_token.inspect.to_s
  	end
	end

end

# 134381003642835