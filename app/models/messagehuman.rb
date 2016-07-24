class Messagehuman
	include Her::Model

	def self.message
		Messagehuman.get("https://api.motion.ai/1.0/messagehuman", :msg => "Do you have homework", :bot => 775, :to => "134381003642835", :key => "172d50fb1a951d0a32dee40804fedab6")
	end
end