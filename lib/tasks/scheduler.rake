desc "This task is called by the Heroku scheduler add-on"
require 'json'
task :message_task => :environment do
	@groups = Group.all.order("end_time ASC").where("group_day = ?", 0.hours.ago.strftime("%A").downcase).where("extra_class = ?", false)
	@t = 0.minutes.from_now.utc.strftime("%H:%M:%S")
	@timeten = 10.minutes.from_now.utc.strftime("%H:%M:%S")
	puts "@t: " + @t.inspect
	puts "@timeten: " + @timeten.inspect

	@groups.each do |group|
		if group.time_zone.to_i < 0
			puts "end time 1: " + group.end_time.inspect
			group.end_time = group.end_time + (group.time_zone * -1).hours
			puts "end time 2: " + group.end_time.inspect
		else
			puts "end_time 1: " + group.end_time.inspect
			group.end_time = group.end_time - group.time_zone.hours
			puts "end_time 2: " + group.end_time
		end
		

		if group.end_time.strftime("%H:%M:%S") >= @t && group.end_time.strftime("%H:%M:%S") <= @timeten
			puts "group: " + group.group_name.to_s + " " + group.conversation_id.to_s
			Messagehuman.sendBinaryMessage(group.conversation_id, 'Do you have homework for ' + group.group_name)
			@group = group.as_json
			@group["id"] = nil
			@group.delete("name")
			checkExistingGroupArray = Grouparray.find_by(conversation_id: group.conversation_id)
			checkExistingGroupArray.destroy if !checkExistingGroupArray.nil?
			groupArrayNew = Grouparray.new(@group)
			groupArrayNew.save
		end
	end
	
end

task :reset_classes => :environment do
	@groups = Group.all.where("group_day = ?", 1.minutes.from_now.strftime("%A").downcase)
	@groups.each do |group|
		group.update(homework_assigned: nil, homework_assignment: nil)
	end
end

task :reset_user_homework => :environment do
	@users = User.all
	@users.each do |user|
		@midnight = 0.minutes.from_now.utc - (user.time_zone * -1).hours
		if @midnight.strftime("%H:%M:%S") == "00:00:00"
			user.update(sentHomwork: false)
		end
	end
end


task :send_homework => :environment do
	@users = User.all
	@users.each do |user|
		puts "one"
		if user.sentHomwork == false || user.sentHomwork == nil
			puts "two"
		if !user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).nil? && !user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).order("end_time asc").limit(user.class_number.to_i).last.nil?
			puts "three"
			if user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).order("end_time ASC").limit(user.class_number.to_i).last.homework_assigned != nil
				puts "four"
				homeworkGroups = Array.new
				homeworkGroupsTrue = Group.where("homework_assigned = ?", true).where("group_day = ?", 0.hours.ago.strftime("%A").downcase).where("conversation_id = ?", user.conversation_id)
				homeworkGroupsTrue.each do |group|
					homeworkGroups.push(group)
				end
				puts "five"
				homeworkGroupsString = String.new
				counter = 1
				homeworkGroups.each do |group|
					puts "six"
					if counter != 1
						homeworkGroupsString = homeworkGroupsString + ", " + group.group_name + ": " + group.homework_assignment + "\n"
					else
						homeworkGroupsString = homeworkGroupsString + group.group_name + ": " + group.homework_assignment + "\n"
					end
				end
				puts 'user send to: ' + user.first_name.to_s
				if !homeworkGroupsString.blank?
					Messagehuman.sendMessage(user.groups.last.conversation_id, 'You have homework for... ' + "\n" + homeworkGroupsString)
					Messagehuman.sendSummaryButton(user.groups.last.conversation_id)
					user.update(sentHomwork: true)
				else
					Messagehuman.sendMessage(user.groups.last.conversation_id, 'Yay. You have no homework.')
					user.update(sentHomwork: true)
				end		
			end
		end
	end
end
end
