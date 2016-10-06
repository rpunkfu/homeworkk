class Messenger < Messenger::MessengerModel
	def sendMessage
		Messenger::Client.send(
      Messenger::Request.new(
        Messenger::Elements::Text.new(text: 'how you doin'),
        134381003642835
      )
    )
  end
end