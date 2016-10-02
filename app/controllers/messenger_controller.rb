class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

  end

  def webhook_inspect
  end
end