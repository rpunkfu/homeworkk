class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

 def receive_message
 	checkFacebookToken() # checks to make sure that the token from facebook is correct
 	$webhook = request.raw_post
 end

 def webhook_inspect
 end
end