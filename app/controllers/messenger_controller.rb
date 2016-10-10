class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

	def receive_message
 		$webhook = JSON.parse(request.raw_post)
 	end

 	def webhook
 		checkFacebookToken()
 	end

 	def webhook_inspect
 	end
 
end