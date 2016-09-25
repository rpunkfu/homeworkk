class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

    #logic here

  Messenger::Client.send(
    Messenger::Request.new(
      Messenger::Elements::Text.new(text: 'some text'),
      1135063803224611
    )
  )



    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end