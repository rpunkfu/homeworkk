class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"].downcase
 		currentClasses = Grouparray.all

 		@checkUserExists = Messagehuman.checkUserExists
 		Messagehuman.sendButton(@recipient) if User.find_by(conversation_id: @recipient).nil? && @checkUserExists == false
 		#@checkUserExists = Messagehuman.checkUserExists(@recipient)
 		#Messagehuman.sendMessage(@recipient, @checkUserExists)

 		currentClasses.each do |group|
 			randomNum = rand(0..7)
 			if group.conversation_id == @recipient
 				if @userText == "yes"
 					Messagehuman.sendMessage(group.conversation_id, @negativeResponses[randomNum])
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name, group_day: group.group_day, end_time: group.end_time)
 					@group.update(homework_assigned: true)
 				elsif @userText == "no"
 					Messagehuman.sendMessage(group.conversation_id, @positiveResponses[randomNum])
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name)
 					@group.update(homework_assigned: false)
 				else
 					
 				end
 			end
 		end
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		@user = User.find_by(conversation_id: '134381003642835')
 	end
 
end