class Messagehuman


	def self.sendMessage(recipient, message)
		page_access_token = 'EAAZAjj9YZAiZC0BAMJmsPEAp8PEhWvOc1DEDrPQFkzZBZBd9BgCx8ZCzRk7LAQHxSkJZARMS9vGiIihyyenuzsZBqkMAeEW7vT3ukxjRRqHRTbBx5BlNauoXtgwy3lR6zosx70CzgiyiLZArTr1mZCQoqZBrsDOZAerirrbBHL2wumq19wZDZD'
 		body = {
 			recipient: {
   			id: recipient
 			},
 			message: {
   			text: message
 			}
		}.to_json
		response = HTTParty.post(
 			"https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

	def self.sendBinaryMessage(recipient, message)
		page_access_token = 'EAAZAjj9YZAiZC0BAMJmsPEAp8PEhWvOc1DEDrPQFkzZBZBd9BgCx8ZCzRk7LAQHxSkJZARMS9vGiIihyyenuzsZBqkMAeEW7vT3ukxjRRqHRTbBx5BlNauoXtgwy3lR6zosx70CzgiyiLZArTr1mZCQoqZBrsDOZAerirrbBHL2wumq19wZDZD'
 		body = {
 			recipient: {
   			id: recipient
 			},
 			message: {
   			text: message,
   			quick_replies: [
      	{
        	content_type: "text",
        	title: "Yes", 
        	payload: 'Yes'	
      	},
      	{
        		content_type: "text",
        		title: "No",
        		payload: 'No'
      		}
   			]
 			}
		}.to_json
		response = HTTParty.post(
 			"https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

	def self.checkKeyWords(userText)
		case userText.downcase
		when "getting started"
			@messageText = 'Hi, I am Christopher Bot'
			return @messageText
		when "hi"
			@messageText = "Hi, I'm Christopher; the coolest bot around"
			return @messageText
		else 
			@messageText = "Sorry, I don't understand; I have a small vocabulary right now"
			return @messageText
		end
	end

	def self.checkUserExists(recipient)
		if User.find_by(conversation_id: recipient).nil?
 			@messageText = 'sign up for christopherbot here: https://christopherbot.herokuapp.com/users/sign_in/?conversation_id=' + recipient
 		else
 			@messageText = "good news... you've already signed up!"
 		end
 		return @messageText
 	end

 	def self.sendButton(recipient)
  page_access_token='EAAZAjj9YZAiZC0BAMJmsPEAp8PEhWvOc1DEDrPQFkzZBZBd9BgCx8ZCzRk7LAQHxSkJZARMS9vGiIihyyenuzsZBqkMAeEW7vT3ukxjRRqHRTbBx5BlNauoXtgwy3lR6zosx70CzgiyiLZArTr1mZCQoqZBrsDOZAerirrbBHL2wumq19wZDZD'
 	body = {
 		"recipient":{
    	id: recipient
  	},
  	message:{
    	attachment:{
     		type:"template",
     		payload: {
       		template_type:"generic",
        	elements:[
         	{
            title:"Sign Up For Christopher Bot",
           	item_url:"https://christopherbot.herokuapp.com/users/sign_in?conversation_id=" + recipient,
           	subtitle:"To get daily reminders of your homework",
           	buttons:[
              			{
                type:"web_url",
               	url:"https://christopherbot.herokuapp.com/users/sign_in?conversation_id=" + recipient,
                title:"Sign Up",
                webview_height_ratio:"tall"
              }
            	]
          	}
        	]
      	}
   	}
 	 } 
  }.to_json

	response = HTTParty.post(
	 	"https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
	 	body: body,
	 	headers: { 'Content-Type' => 'application/json' }
	)
end
			
end