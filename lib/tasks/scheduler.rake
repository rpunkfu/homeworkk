desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
			Messenger::Client.send(
      	Messenger::Request.new(
        	Messenger::Elements::Text.new(text: "hi"),
        	134381003642835
      	)
    	)
    end
  end
end