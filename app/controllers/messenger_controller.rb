class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		if User.find_by(conversation_id: recipient.to_s).nil?
 			message = 'sign up for christopherbot here: https://christopherbot.herokuapp.com/users/sign_in/?conversation_id=#{recipient}'
 		else
 			message = 'you are already signed up'
 		end

 		Messagehuman.sendMessage(recipient, message)
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 	end
 
end