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
 				if @userText == "Yes"
 					Messagehuman.sendMessage(group.conversation_id, "that's too bad")
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name)
 					@group.update(homework_assigned: true)
 				elsif @userText == "No"
 					Messagehuman.sendMessage(group.conversation_id, "thats good")
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 				else
 					Messagehuman.sendMessage(group.conversation_id, "failed logic")		
 				end
 			end
 		end

 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		
 	end
 
end