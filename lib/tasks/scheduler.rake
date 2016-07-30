desc "This task is called by the Heroku scheduler add-on"

task :message_task => :environment do
  puts "preparing to send the message"
  Messagehuman.message
  puts "message sent."
end