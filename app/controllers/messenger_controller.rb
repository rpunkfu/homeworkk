class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

    #logic here
    Messenger::Request.new("hello, how are you?", 134381003642835)

    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end