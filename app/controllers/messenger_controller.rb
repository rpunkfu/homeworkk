class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
 		$webhook = JSON.parse(request.raw_post)
 		page_access_token = 'EAAZAjj9YZAiZC0BALu16ZCAkRt33hbnZAqeZBSJgBqjTiEjYz9eP2InIpwbolx7xe8bhfJ9o6oLRTGId6oZCBAbUMoFGgYlZCGVT2NbIcq3dkVAdgw5jh3ZCIT9CDONkx5QSp7nlRcrX5HncCAKwZBBft8UjitoLMgDJXNul7dIzlfbgZDZD'

	  body = {
	   recipient: {
	     id: '134381003642835'
	   },
	   message: {
	     text: 'this is webhook'
	   }
	  }.to_json
	  logger.debug body
	  response = HTTParty.post(
	   "https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
	   body: body,
	   headers: { 'Content-Type' => 'application/json'}
	  )
	  render :nothing => true, status: 200
 	end

 	def sendtoken
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		
 	end
 
end