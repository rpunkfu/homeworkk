class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		page_access_token = 'EAAZAjj9YZAiZC0BAC5Od9ZCwqeVIRMJe0cWgys7ZA8vEbtlCNNyqpfhZBJN8a1WjZBoLow5ZBZAI0sbOagP3YQgPbWL3qCchCmUK7aodkHlmhfs9PmdQueNLpK0Nvib9IkZBEdkrLzksxSA4qn7zWnFJazP4eS8l16u6eqxAmI1FpTMAZDZD'

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
	  render nothing => true, status: 200
 	end

 	def webhook_inspect
 		
 	end
 
end