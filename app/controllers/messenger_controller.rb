class MessengerController < ApplicationController
	require 'json'



 def receive_message
 	if params['hub.verify_token'] == '123456789'
   		puts "this is successful"
     render text: params['hub.challenge'] and return
   else
   	puts "this is not good"
     render text: 'ahhhhhhh, error' and return
   end
 	$webhook = request.raw_post
 end

 def webhook_inspect
 end
end