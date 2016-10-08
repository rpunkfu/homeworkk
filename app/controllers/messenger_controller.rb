class MessengerController < ApplicationController
	require 'json'

  def webhook
   if params['hub.verify_token'] == '123456789'
   		puts "this is successful"
     render text: params['hub.challenge'] and return
   else
   	puts "this is not good"
     render text: 'ahhhhhhh, error' and return
   end
 end

 def receive_message
 	$webhook = request.raw_post
 end

 def webhook_inspect
 end
end