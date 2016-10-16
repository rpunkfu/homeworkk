module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		puts "params 3 inspect " + params["hub.challenge"].inspect
		puts "params 4 inspect " + params["hub.verify_token"].to_i.inspect
		puts "params hub.mode " + params["hub.mode"].to_i.inspect
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params.inspect + verify_token.inspect
  	end
	end

end

# 134381003642835