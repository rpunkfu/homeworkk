class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		sendUserMessage()
 	end

 	def webhook_inspect
 		
 	end
 
end