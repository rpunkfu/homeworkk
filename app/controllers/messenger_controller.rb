class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"].downcase if !$webhook["entry"][0]["messaging"][0]["message"]["text"].nil?

 		$userStartText = $webhook["entry"][0]["messaging"][0]["postback"]["payload"] if !$webhook["entry"][0]["messaging"][0]["postback"]["payload"].nil? && @userText.nil?
 		$userStartRecipient = $webhook["entry"][0]["messaging"][0]["recipient"]["id"] if @recipient.nil? && !$webhook["entry"][0]["messaging"][0]["recipient"]["id"].nil?
 		

 		@positiveResponses = ["thats grrrreaat", "Thats Awesome!", "Yay! No Homework!", "Finally, a break from some homework", "Awesome. Just what i needed to hear.", "Yay. Some good news today.", "thats almost better than harry potter", "time to celebrate, come on!"]
		@negativeResponses = ["booooo.", "what a shame." "ugh. That stinks.", "your teacher needs to chill out on the homework", "That's so sad to hear", "that sucks, at least you look good today.", "that sucks more than a vacuum", "thats worse than when Dumbledore died."]
		@defaultResponses = ["Hey! You've already signed up. All you have to do is wait for me to text you"]
		@sentMessage = false
 		currentClasses = Grouparray.all

 		if @userStartText.nil? && @userStartRecipient.nil?
 			@checkUserExists = Messagehuman.checkUserExists(@recipient)
	 		if @checkUserExists == false
	 			Messagehuman.sendMessageBubbles(@recipient)
	 			sleep(2)
	 			Messagehuman.sendButton(@recipient) if User.find_by(conversation_id: @recipient).nil? && @checkUserExists == false
	 			@sentMessage = true
	 		end
	 	else
	 		@checkUserExists = Messagehuman.checkUserExists(@userStartRecipient)
	 		if @checkUserExists == false || @sentMessage == false
	 			Messagehuman.sendMessageBubbles(@recipient)
	 			sleep(2)
	 			Messagehuman.sendButton(@userStartRecipient)
	 		end
 		end
 		
 		currentClasses.each do |group|
 			randomNum = rand(0..7)
 			if group.conversation_id == @recipient
 				if @userText == "yes"
 					puts "yes"
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name, group_day: group.group_day)
 					puts "group thing: " + @group.group_name.inspect
 					@group.update(homework_assigned: true)
 					@grouparray = Grouparray.find_by(id: group.id)
 					@grouparray.update(homework_assigned: true)
 					Messagehuman.sendMessageBubbles(group.conversation_id)
 					sleep(2)
 					Messagehuman.sendMessage(group.conversation_id, @negativeResponses[randomNum])
 					Messagehuman.sendMessageBubbles(group.conversation_id)
 					sleep(2)
 					Messagehuman.sendMessage(group.conversation_id, 'what homework do you have?')
 					@sentMessage = true
 				elsif @userText == "no"
 					Messagehuman.sendMessageBubbles(group.conversation_id)
 					sleep(2)
 					Messagehuman.sendMessage(group.conversation_id, @positiveResponses[randomNum])
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name, group_day: group.group_day)
 					@group.update(homework_assigned: false)
 					@sentMessage = true
 				elsif group.homework_assigned == true
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name, group_day: group.group_day)
 					@group.update(homework_assignment: @userText)
 					@groupArray = Grouparray.find_by(id: group.id)
 					@groupArray.destroy
 					Messagehuman.sendMessageBubbles(group.conversation_id)
 					sleep(2)
 					Messagehuman.sendMessage(group.conversation_id, 'Ok Dokey! Got it!')
 					@sentMessage = true
 				else
 				end
 			end
 		end
 		if @sentMessage == false
 			Messagehuman.sendMessageBubbles(@recipient)
 			sleep(2)
 			Messagehuman.sendMessage(@recipient, @defaultResponses[0])
 		end
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		@user = User.find_by(conversation_id: '134381003642835')
 	end
 
end