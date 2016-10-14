class Messagehuman
	require 'json'
	require 'httparty'

	def self.sendMessage
		page_access_token = 'EAAZAjj9YZAiZC0BAKcEcxiHW1pVVTv1AdwLBJTp65YqtZBxK7Rk60Y8iZACnm2ePSThDRrUW4qiD0f3P3dCg4GM9fWXLaKqD1Seicclhx9eRokj8ZBwrpOepGcSmRDXweI2lvXTjEgcY3OeBPwJmT2NjbvsC4ZApeZBWTBSGyoFsHAZDZD'

	  body = {
	   recipient: {
	     id: '134381003642835'
	   },
	   message: {
	     text: 'hi alec'
	   }
	  }.to_json
	  
	  response = HTTParty.post(
	   "https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
	   body: body,
	   headers: { 'Content-Type' => 'application/json' }
	  )
	  render :nothing => true, :status => 200
	end
end