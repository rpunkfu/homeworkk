class MessengerController < Messenger::MessengerController
	require 'json'

  def webhook
  	$webhook = JSON.parse(request.raw_post)

    #logic here
  	if fb_params.first_entry.callback.message?
  		if User.find_by(conversation_id: fb_params.first_entry.sender_id).nil?
  			text = "https://christopherbot.herokuapp.com/users/sign_in?conversation_id=#{fb_params.first_entry.sender_id}"
      else
        text = "hello, you've already signed up, can't wait to show you what I can do in the future"
  		end
    
    Messenger::Client.send(
      Messenger::Request.new(
        Messenger::Elements::Text.new(text: text),
        fb_params.first_entry.sender_id
      )
    )

		end

    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end