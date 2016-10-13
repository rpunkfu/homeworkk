module MessengerHelper

	def checkFacebookToken
		if params['hub.verify_token'] == '123456789'
    	render text: params['hub.challenge'] and return
  	else
    	render text: 'ahhhhhhh, error' and return
  	end
	end

	def sendUserMessage()
		access_token = "EAAZAjj9YZAiZC0BAHofK78pYfkKG7DRUvKnGraNZAHmVi8vzq9NdGSZBbO15rgvu0ubZAu7YXGCHpoGeUqcmtKFDT3OYOZCFSIVAWmylmGmxriUts1DVtMzpXmVMJeSZAshRRoIy293BwnLkLqz8d0Owq4nhLB0oKvMbyaDqeMZBHnwZDZD"
		url = "https://graph.facebook.com/v2.6/me/messages?access_token=" + access_token
		sender_id = 134381003642835
		message = "connor eats pizza"

		options = {
        body: {
          recipient: {id: sender_id},
          message: {text: message}
        }
		}

		result = HTTParty.post(url, options)
		print result
	end

end

# 134381003642835