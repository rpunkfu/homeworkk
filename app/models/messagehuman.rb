class Messagehuman
	def self.sendMessage(recipient, message)
		page_access_token = 'EAAZAjj9YZAiZC0BAHnGNh9baN7nOD5fXxglWkzJ2ZBrQt0kZAXs7lX95PRjyaRlZAHgU05bQMOZCzjv3jndQZAgHMQATBtDglSCrg5FZA7mmVDb75sLG2hrqHaNaChVUbCu166D0FHE40Fikv3aZB1w6Xg7YKYfoCsNw90z79auXDGZCQZDZD'
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
		case userText.downcase
		when "getting started"
			@messageText = 'Hi, I am Christopher Bot'
			return @messageText
		when "hi"
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