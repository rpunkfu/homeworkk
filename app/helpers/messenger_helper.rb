module MessengerHelper

	def checkFacebookToken
		if params['hub.verify_token'] == '123456789'
    	render text: params['hub.challenge'] and return
  	else
    	render text: 'ahhhhhhh, error' and return
  	end
	end

	def sendUserMessage(user, text)
		body = {recipient:{id: user}, message:{text: text}}.to_json
		response = Message.post(
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

end

# 134381003642835