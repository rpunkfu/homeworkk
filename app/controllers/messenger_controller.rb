class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

	def webhook
 		checkFacebookToken() # checks to make sure that the token from facebook is correct
 		$webhook = JSON.parse(request.raw_post)
 		puts "webhook page has loaded"
 		# sendUserMessage('134381003642835', "hi alec")
 	end

 	def webhook_inspect
 	end
 
end