desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
	puts "Scanning for groups"
	groups = Group.all
	groups.each do |group|
		puts group.inspect
	end
	puts "finished"
end