class Messagehuman
	include Her::Model

	def self.message(person, message)
		Messagehuman.get("https://api.motion.ai/1.0/messagehuman", :msg => message, :bot => 775, :to => person, :key => "172d50fb1a951d0a32dee40804fedab6")
	end
end