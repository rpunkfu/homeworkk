class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		sendUserMessage('134381003642835', "alec still rules all")
 	end

 	def webhook_inspect
 		
 	end
 
end