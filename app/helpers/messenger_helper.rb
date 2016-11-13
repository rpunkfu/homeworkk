module MessengerHelper

	def checkFacebookToken
		verify_token = params["hub.verify_token"]
		if verify_token == "123456789"
    	render text: params['hub.challenge'] and return
  	else
    	render text: "failed" and return
  	end
	end

	@positiveResponses = ["thats grrrreaat", "Thats Awesome!", "Yay! No Homework!", "Finally, a break from some homework", "Awesome. Just what i needed to hear.", "Yay. Some good news today.", "thats almost better than harry potter", "time to celebrate, come on!"]
	@negativeResponses = ["booooo.", "what a shame." "ugh. That stinks.", "your teacher needs to chill out on the homework", "That's so sad to hear", "that sucks, at least you look good today.", "that sucks more than a vacuum", "thats worse than when Dumbledore died."]

end

# 134381003642835