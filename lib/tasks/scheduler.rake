desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
	puts "sending group message.."
	Group.sendMessage(134381003642835, "Hi! I sent a message")
	puts "sent."
end