class MessengerController < Messenger::MessengerController
	require 'json'
  include MessengerHelper

  def webhook
  	$webhook = JSON.parse(request.raw_post)
    

    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end