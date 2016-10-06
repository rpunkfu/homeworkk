include ApplicationHelper

desc "This task is called by the Heroku scheduler add-on"


task :message_task => :environment do
	sendMessageToUser()
end