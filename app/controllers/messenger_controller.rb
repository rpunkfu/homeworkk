class MessengerController < ApplicationController
	require 'json'

  def webhook
  	$webhook = JSON.parse(request.raw_post)

   if params[‘hub.verify_token’] == “1234”
     render text: params[‘hub.challenge’] and return
   else
     render text: ‘error’ and return
   end
 end

 def webhook_inspect
 end
end