desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
	@groups = Group.all
	@groups.each do |group|
		if group.end_time >= Time.now && group.end_time <= Time.now + 10*60
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