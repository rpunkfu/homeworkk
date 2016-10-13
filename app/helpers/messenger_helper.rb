module MessengerHelper

	def checkFacebookToken
		if params['hub.verify_token'] == '123456789'
    	render text: params['hub.challenge'] and return
  	else
    	render text: 'ahhhhhhh, error' and return
  	end
	end

	def sendUserMessage(senderId, messageString)
		if !$webhook.nil?
			access_token = "EAAZAjj9YZAiZC0BAHJ2zRhGWF8FgzAu8NTWCwD7tQ3IsrH1gVsDiMzJgFD6kyFHY6BuCK5XyorlFGHg3H3tvZBiNRUuAJg3ZCtYDMTts2ZC4leEcYhZC6rBuGc6rZCTxckz0xUOPSqIQn6fxHvJJxMiyk7mbGvP4KoAIOXwgZA6hCkwZDZD"
			url = "https://graph.facebook.com/v2.6/me/messages?access_token=" + access_token
			sender = senderId
			message = messageString

			options = {
	        body: {
	          recipient: {id: sender},
	          message: {text: message}
	        }
			}

			result = HTTParty.post(url, options)
			print result
		end
	end

end

# 134381003642835