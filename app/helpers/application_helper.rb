module ApplicationHelper
	def sendMessageToUser
		Messenger::Client.send(
      Messenger::Request.new(
        Messenger::Elements::Text.new(text: 'suhhh dude'),
        134381003642835
      )
    )
  end
end
