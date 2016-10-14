class Messagehuman
	def self.sendMessage
			access_token = "EAAZAjj9YZAiZC0BAHJ2zRhGWF8FgzAu8NTWCwD7tQ3IsrH1gVsDiMzJgFD6kyFHY6BuCK5XyorlFGHg3H3tvZBiNRUuAJg3ZCtYDMTts2ZC4leEcYhZC6rBuGc6rZCTxckz0xUOPSqIQn6fxHvJJxMiyk7mbGvP4KoAIOXwgZA6hCkwZDZD"
			url = "https://graph.facebook.com/v2.6/me/messages?access_token=" + access_token
			sender = 134381003642835
			message = 'how you doin'

			options = {
	        body: {
	          recipient: {id: sender},
	          message: {text: message}
	        }
			}

			result = HTTParty.post(url, options)
			print result
	end
end