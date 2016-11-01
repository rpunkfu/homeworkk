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
		if !user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last.homework_assigned.nil?
			if user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last.homework_assigned == true || user.groups.where("group_day = ?", Time.now.strftime("%A").downcase).last.homework_assigned == false
				puts 'line 28'
				homeworkGroups = user.groups.where("group_day = ?", Time.now.strftime("%A")).where("homework_assigned = ?", true)
				homeworkGroups.each do |group|
					puts group.group_name.inspect
				end
				puts "heyllo: " + homeworkGroups.inspect
				#Messagehuman.sendMessage(user.groups.last.conversation_id, 'You have homework for: ' + homeworkGroups)
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