class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

    #logic here
  	if fb_params.first_entry.callback.message?
  		if User.where("conversation_id = ?", fb_params.first_entry.sender_id) == true
  			text = "https://christopherbot.herokuapp.com/users/sign_in?conversation_id=#{fb_params.first_entry.sender_id}"
	  		messageText = Messenger::Elements::Text.new(text: text), fb_params.first_entry.sender_id
	  		
	  		Messenger::Client.send(
	    		Messenger::Request.new(messageText)
	    	)
	    end
		end

    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end