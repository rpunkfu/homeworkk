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
 			"https://graph.facebook.com/v2.6/me/messages?access_token=EAAZAjj9YZAiZC0BAFZCao4ZADSMy9o60qDLr2y8zvB14OElmfuXyNq6LbjRwwSPAptK9eNGcHI73VLKaTrk5R6nanUa7mFJPD0Rp5p0p0ZBPOanIRkZABOX9ZC590Q5WfNAABPlRwf1GmWRhhtxnMgeOZBcylDMCrpwjXOS1NBaTDwwZDZD",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

end

# 134381003642835