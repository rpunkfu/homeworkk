module MessengerHelper

	def checkFacebookToken
		verify_token = params[3]
		puts "params inspect " + params[2].inspect
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: params.inspect + verify_token.inspect
  	end
	end

end

# 134381003642835