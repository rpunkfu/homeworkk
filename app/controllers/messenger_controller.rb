class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		$currentClasses = Array.new
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"]
 		@messageText = "do you have homework for math"

 		Messagehuman.sendBinaryMessage(@recipient, @messageText)
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect

 	end
 
end