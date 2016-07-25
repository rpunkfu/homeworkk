desc "This task is called by the Heroku scheduler add-on"

task :message_task => :production do
  puts "Updating feed..."
  Messagehuman.message
  puts "done."
end