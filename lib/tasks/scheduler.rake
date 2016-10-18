desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
	Group.each do |group|
		if group.end_time >= Time.now && group.end_time <= Time.now + 10*60
			Messagehuman.sendMessage(group.conversation_id, group.name)
		end
	end
end