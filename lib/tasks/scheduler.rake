desc "This task is called by the Heroku scheduler add-on"
require 'json'
task :message_task => :environment do
	@groups = Group.all.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).order("end_time ASC")
	@t = 0.minutes.from_now.strftime("%H:%M:%S")
	@timeten = 10.minutes.from_now.strftime("%H:%M:%S")


	@groups.each do |group|
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
		group.update(homework_assigned: nil)
	end

	@users = User.all
	@users.each do |user|
		user.update(sentHomwork: false)
	end
end

task :send_homework => :environment do
	@users = User.all
	@users.each do |user|
		if user.sentHomwork == false
		if !user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).nil? || !user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).last.nil?
		if !user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).order("end_time ASC").last.homework_assigned.nil?
			if user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).order("end_time ASC").last.homework_assigned == true || user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).order("end_time ASC").last.homework_assigned == false
				homeworkGroups = Array.new
				homeworkGroupsTrue = Group.where("homework_assigned = ?", true).where("conversation_id = ?", user.conversation_id)
				homeworkGroupsTrue.each do |group|
					homeworkGroups.push(group.group_name)
				end
				puts 'user send to: ' + user.first_name.to_s
				Messagehuman.sendMessage(user.groups.last.conversation_id, 'You have homework for: ' + homeworkGroups.to_s)
				user.update(sentHomwork: true)
			end
		end
		end
	end
end
end