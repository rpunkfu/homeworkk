class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"]
=begin
 		currentClasses.each do |group|
 			if group.conversation_id == @recipient
 				if @userText == "Yes"
 					Messagehuman.sendMessage(group.conversation_id, "that's too bad")
 				elsif @userText == "No"
 					Messagehuman.sendMessage(group.conversation_id, "thats good")
 				else
 					Messagehuman.sendMessage(group.conversation_id, "failed logic")
 				end
 			end
 		end
=end

 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		#@group = Group.first.as_json
 		#@group["id"] = nil
 		#@grouparray = Grouparray.new(@group)
 		#@grouparray.save
 	end
 
end