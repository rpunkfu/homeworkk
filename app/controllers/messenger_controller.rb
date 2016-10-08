class MessengerController < ApplicationController
	require 'json'

  def webhook
   if params[‘hub.verify_token’] == “123456789”
     render text: params[‘hub.challenge’] and return
   else
     render text: ‘error’ and return
   end
 end

 def receive_message
 	$webhook = request.raw_post
 end

 def webhook_inspect
 end
end