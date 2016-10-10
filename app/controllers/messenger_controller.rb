class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

	def webhook
 		checkFacebookToken() # checks to make sure that the token from facebook is correct
 		$webhook = JSON.parse(request.raw_post)

 		if !$webhook.nil?
 			#sendUserMessage('134381003642835', "hi alec")
 		end
 	end

 	def webhook_inspect
 	end
 
end