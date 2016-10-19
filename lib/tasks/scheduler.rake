desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
	@groups = Group.all 
	@t = Time.now.utc.strftime("%H:%M:%S")
	@timeten = 10.minutes.from_now.utc.strftime("%H:%M:%S")

	@groups.each do |group|
		if group.end_time.utc.strftime("%H:%M:%S") >= @t && group.end_time.utc.strftime("%H:%M:%S") <= @timeten
			Messagehuman.sendMessage(group.conversation_id, group.group_name)
		end
	end

end