class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
 		$webhook = JSON.parse(request.raw_post)
 		page_access_token = 'EAAZAjj9YZAiZC0BALdZB6lBltZAenVPyLZBDN5ZBD0NecQBZCBHYIkH2eF7MvGgomp8ZB4ZCqgnZAqqZAYIpRqsWf0HT8H1MHjgAGUZAsK45r6GAqgBb5jZA33BGBEZBTNhJND880K76nafD4AtmuZBNPF0yzZAN1MUZCjL7fGZCzLBkoL02jlX4gZDZD'

	  body = {
	   recipient: {
	     id: '134381003642835'
	   },
	   message: {
	     text: 'this is webhook'
	   }
	  }.to_json
	  
	  response = HTTParty.post(
	   "https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
	   body: body,
	   headers: { 'Content-Type' => 'application/json' }
	  )
	  render :nothing => true, status: 200
 	end

 	def sendtoken
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		
 	end
 
end