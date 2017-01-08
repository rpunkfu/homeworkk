class MessageMailer < ActionMailer::Base
	default from: "Alec E Jones <noreply@christopherbot.co>"
  default to: "Alec Jones <alec@christopherbot.co>"


  def new_message(message)
    @message = message
    
    mail subject: "!IMPORTANT! MESSAGE FROM #{message.name}"
  end
end
