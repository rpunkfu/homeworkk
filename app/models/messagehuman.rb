class Messagehuman
	def self.sendMessage(recipient, message)
		page_access_token = 'EAAZAjj9YZAiZC0BAEd4jlX7pUkQ975BA9e1NNfdjZBRxGxJ8n3NbndZCXCNqmMCGDyh3ZBjxXxS6PXgw8uZCWNrddK2PtOJMSp1bPlADE6KwgUAc7RmwyvTDlT1p8MACQzyXs65uA9dzhQmdE8IoT6xxbFth3mIabx6XgxJqZAAx4AZDZD'
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

	def self.checkKeyWords(userText)
		case userText
		when 'Getting Started'
			@messageText = 'Hi, I am Christopher Bot'
			return @messageText
		when 'Hi' || 'hi'
			@messageText = "Hi, I'm Christopher; the coolest bot around"
			return @messageText
		else 
			@messageText = 'Sorry, error'
			return @messageText
		end
	end

	def self.checkUserExists(recipient)
		if User.find_by(conversation_id: recipient).nil?
 			@messageText = 'sign up for christopherbot here: https://christopherbot.herokuapp.com/users/sign_in/?conversation_id=' + recipient
 		else
 			@messageText = ''
 		end
 		return @messageText
 	end
			
end