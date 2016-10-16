class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 	end
 
end