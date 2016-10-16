class Messagehuman
	def self.sendMessage(recipient, message)
		page_access_token = 'EAAZAjj9YZAiZC0BALu16ZCAkRt33hbnZAqeZBSJgBqjTiEjYz9eP2InIpwbolx7xe8bhfJ9o6oLRTGId6oZCBAbUMoFGgYlZCGVT2NbIcq3dkVAdgw5jh3ZCIT9CDONkx5QSp7nlRcrX5HncCAKwZBBft8UjitoLMgDJXNul7dIzlfbgZDZD'
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
		else 
			@messageText = 'Sorry, error'
			return @messageText
		end
	end

	def self.checkUserExists(recipient)
		if User.find_by(conversation_id: recipient.to_s).nil?
 			@messageText = 'sign up for christopherbot here: https://christopherbot.herokuapp.com/users/sign_in/?conversation_id=#{recipient}'
 			return @messageText
 		end
 	end
			
end