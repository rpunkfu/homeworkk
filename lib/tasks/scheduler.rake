desc "This task is called by the Heroku scheduler add-on"
require 'json'
task :message_task => :environment do
	@users = User.all
	@users.each do |user|
		if user.groups.where("group_day = ?", "Monday".downcase).last.end_time == true
			homeworkGroups = user.groups.group_name.where("group_day = ?", "Monday").where("homework_assigned = ?", true).to_a
			Messagehuman.sendMessage(user.groups.last.conversation_id, 'You have homework for: ' + homeworkGroups)
		end
	end

	@groups = Group.all.where("group_day = ?", Time.now.strftime("%A").downcase)
	@t = 0.minutes.from_now.strftime("%H:%M:%S")
	@timeten = 10.minutes.from_now.strftime("%H:%M:%S")


	@groups.each do |group|
		if group.end_time.strftime("%H:%M:%S") >= @t && group.end_time.strftime("%H:%M:%S") <= @timeten
			Messagehuman.sendBinaryMessage(group.conversation_id, 'Do you have homework for ' + group.group_name)
			@group = group.as_json
			@group["id"] = nil
			@group.delete("name")
			groupArrayNew = Grouparray.new(@group)
			groupArrayNew.save
		end
	end
end