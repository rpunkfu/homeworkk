# YOUR_APP/app/controllers/messenger_controller.rb
class MessengerController < Messenger::MessengerController
  def webhook
  	$webhook = URI::decode_www_form(request.raw_post)
    #logic here
    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end