class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

    #logic here
  	if fb_params.first_entry.callback.message?
  		if User.where("conversation_id = ?", fb_params.first_entry.sender_id).empty?
  			text = "https://christopherbot.herokuapp.com/users/sign_in?conversation_id=#{fb_params.first_entry.sender_id}"
  		end
  		
  	  sendUserMessage(text, user)
		end

    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end