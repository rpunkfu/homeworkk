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
		response = HTTParty.post(
 			"https://graph.facebook.com/v2.6/me/messages?access_token=EAAZAjj9YZAiZC0BAHofK78pYfkKG7DRUvKnGraNZAHmVi8vzq9NdGSZBbO15rgvu0ubZAu7YXGCHpoGeUqcmtKFDT3OYOZCFSIVAWmylmGmxriUts1DVtMzpXmVMJeSZAshRRoIy293BwnLkLqz8d0Owq4nhLB0oKvMbyaDqeMZBHnwZDZD",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

end

# 134381003642835