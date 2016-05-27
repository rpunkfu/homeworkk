class Messagehuman
	include Her::Model

	def self.message
		Messagehuman.get("https://api.motion.ai/1.0/messagehuman", :msg => "This is your daily text at 12:08", :bot => 775, :to => "10153929717001747", :key => "172d50fb1a951d0a32dee40804fedab6")
	end
end