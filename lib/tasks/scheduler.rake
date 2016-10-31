desc "This task is called by the Heroku scheduler add-on"
require 'json'
task :message_task => :environment do

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
	
	@users = User.all
	puts 'line 22'
	@users.each do |user|
		puts 'line24'
		if !user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last.end_time.nil?
			puts 'line 26'
			puts 'heyo: ' + user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last
			if user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last.end_time == true || user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last.end_time == false
				puts 'line 28'
				homeworkGroups = user.groups.group_name.where("group_day = ?", Time.now.strftime("%A")).where("homework_assigned = ?", true).to_a
				puts "heyllo: " + homeworkGroups.inspect
				Messagehuman.sendMessage(user.groups.last.conversation_id, 'You have homework for: ' + homeworkGroups)
				puts 'sent message.'
			end
		end
	end
end

task :reset_classes => :environment do
	@groups = Group.all
	@groups.each do |group|
		group.update(homework_assigned: nil)
	end
end