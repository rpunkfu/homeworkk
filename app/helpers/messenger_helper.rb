module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		puts "params 2 inspect " + params[2].inspect
		puts "params 1 inspect " + params[1].inspect
		puts "params 3 inspect " + params[3].inspect
		puts "params 4 inspect " + params[4].inspect
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params.inspect + verify_token.inspect
  	end
	end

end

# 134381003642835