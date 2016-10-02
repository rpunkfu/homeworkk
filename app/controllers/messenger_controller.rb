class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

    $inspect = fb_params.first_entry
    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end