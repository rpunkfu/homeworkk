class Messagehuman
	include Her::Model

	def self.message
		Messagehuman.get("https://api.motion.ai/1.0/messagehuman", :msg => "Do you have homework", :bot => 775, :to => "130911673989768", :key => "172d50fb1a951d0a32dee40804fedab6")
	end

	def self.data
		Messagehuman.post("https://christopherbot.herokuapp.com/hooks/motion_callback"
	end
end