class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"]
 		
 		@messageText = Messagehuman.checkKeyWords(userText) # grabs message to send from function
 		# write if statement so if there is a text outputted, it will send that text and then break from the if statement

 		Messagehuman.sendMessage(@recipient, @messageText)
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect

 	end
 
end