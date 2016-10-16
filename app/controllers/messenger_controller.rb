class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		results = checkUserExists(recipient)
 		puts 'hi' + results.inspect
 		#Messagehuman.sendMessage(recipient, 'hellooooo')
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 	end
 
end