class Messagehuman
	def self.sendMessage
			access_token = "EAAZAjj9YZAiZC0BAKcEcxiHW1pVVTv1AdwLBJTp65YqtZBxK7Rk60Y8iZACnm2ePSThDRrUW4qiD0f3P3dCg4GM9fWXLaKqD1Seicclhx9eRokj8ZBwrpOepGcSmRDXweI2lvXTjEgcY3OeBPwJmT2NjbvsC4ZApeZBWTBSGyoFsHAZDZD"
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