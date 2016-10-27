class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"]
 		currentClasses = Grouparray.all

 		currentClasses.each do |group|
 			if group.conversation_id == @recipient
 				puts 'it was equal to recipient'
 				if @userText == "Yes"
 					puts 'text was yes'
 					Messagehuman.sendMessage(group.conversation_id, "that's too bad")
 				elsif @userText == "No"
 					Messagehuman.sendMessage(group.conversation_id, "thats good")
 					puts 'text was no'
 				else
 					Messagehuman.sendMessage(group.conversation_id, "failed logic")
 					puts 'else'
 				end
 			end
 			puts 'the end of the each statement'
 		end

 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		
 	end
 
end