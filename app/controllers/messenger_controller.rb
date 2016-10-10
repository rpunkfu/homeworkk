class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

	def webhook
 		checkFacebookToken() # checks to make sure that the token from facebook is correct
 		$webhook = JSON.parse(request.raw_post)
 		puts "webhook page has loaded"
 		puts "1." + $webhook[:entry][:messaging][:id]
 		puts "2." + $webhook['entry']['messaging']['id']

 		if User.find_by(conversation_id: $webhook[:entry][:messaging][:id]).blank?
 			#sendUserMessage('134381003642835', "hi alec")
 			puts "1. worked"
 		end
 	end

 	def webhook_inspect
 	end
 
end