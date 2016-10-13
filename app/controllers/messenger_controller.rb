class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		$webhook[1][1].each do |key, value|
			key["messaging"].each do |key, value|
				$the_sender_id = key["sender"]["id"]
	 		end
		end
 		sendUserMessage($the_sender_id, "how you doin")
 	end

 	def webhook_inspect
 		
 	end
 
end