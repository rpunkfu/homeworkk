desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
			text = "you have a class that finished"
			Messenger::Client.send(
      	Messenger::Request.new(
        	Messenger::Elements::Text.new(text: text),
        	134381003642835
      	)
    	)
    end
  end
end