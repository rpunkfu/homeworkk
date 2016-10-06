class Group < ActiveRecord::Base
	belongs_to :user

	def self.sendMessage(user, text)
		Messenger::Client.send(
    	Messenger::Request.new(
      	Messenger::Elements::Text.new(text: text),
      	user
    	)	
  	)
  end
end
