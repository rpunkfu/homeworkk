class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		$webhook[1][1].each do |key, value|
			key["messaging"].each do |key, value|
				@sender_id = key["sender"]["id"]
	 		end
		end
 		sendUserMessage(@sender_id, "how you doin")
 	end

 	def webhook_inspect
 		@test = {"object"=>"page", "entry"=>[{"id"=>"1135063803224611", "time"=>1476317596353, "messaging"=>[{"sender"=>{"id"=>"134381003642835"}, "recipient"=>{"id"=>"1135063803224611"}, "timestamp"=>1476317596288, "message"=>{"mid"=>"mid.1476317596288:617e906092", "seq"=>2771, "text"=>"hi"}}]}]}.to_a
 	end
 
end