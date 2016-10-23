desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
	@groups = Group.all #.where("group_day = ?", Time.now.strftime("%A"))
	@t = 0.minutes.from_now.strftime("%H:%M:%S")
	@timeten = 10.minutes.from_now.strftime("%H:%M:%S")
	currentClasses = Messagehuman::CURRENT_CLASSES

	@groups.each do |group|
		if group.end_time.strftime("%H:%M:%S") >= @t && group.end_time.strftime("%H:%M:%S") <= @timeten
			currentClasses.push(group)
			Messagehuman.sendBinaryMessage(group.conversation_id, 'Do you have homework for ' + group.group_name)
			puts "conversation_id: " + group.conversation_id.inspect
			puts "group name: " + group.group_name.inspect
		end
		puts "currentClasses: " + currentClasses
	end

end