class SchedulerFunctions
	def sendMessage
		Messenger::Client.send(
	  	Messenger::Request.new(
	    	Messenger::Elements::Text.new(text: "hi"),
	    	134381003642835
	  	)
		)
	end
end