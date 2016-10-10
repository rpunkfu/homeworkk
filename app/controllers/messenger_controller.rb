class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

	def webhook
 		checkFacebookToken() # checks to make sure that the token from facebook is correct
 		$webhook = JSON.parse(request.raw_post)
 		puts "webhook page has loaded"
 		
 		if !User.find_by(conversation_id: $webhook['entry']['messaging']['id'].to_i).blank?
 			#sendUserMessage('134381003642835', "hi alec")
 			puts "worked"
 		end
 	end

 	def webhook_inspect
 	end
 
end