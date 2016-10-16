class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		Messagehuman.sendMessage('134381003642835', 'testing using params')
 		$recipient = $webhook["entry"][0]["messaging"][0]["sender"]
 		$recipent1 = $webhook["entry"]["messaging"]["sender"]
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 	end
 
end