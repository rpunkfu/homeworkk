class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
=begin
 		$webhook[1][1].each do |key, value|
			key["messaging"].each do |key, value|
				$the_sender_id = key["sender"]["id"]
	 		end
		end
=end 
 		sendUserMessage(134381003642835, "friends is the ultimate show")
 	end

 	def webhook_inspect
 		
 	end
 
end