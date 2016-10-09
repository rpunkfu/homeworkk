class MessengerController < ApplicationController
	require 'json'
	include MessengerHelper

 def receive_message
 	checkFacebookToken() # checks to make sure that the token from facebook is correct
 	$webhook = JSON.parse(request.raw_post)
 	page_access_token = 'EAAZAjj9YZAiZC0BAFZCao4ZADSMy9o60qDLr2y8zvB14OElmfuXyNq6LbjRwwSPAptK9eNGcHI73VLKaTrk5R6nanUa7mFJPD0Rp5p0p0ZBPOanIRkZABOX9ZC590Q5WfNAABPlRwf1GmWRhhtxnMgeOZBcylDMCrpwjXOS1NBaTDwwZDZD'

 	
 end

 def webhook_inspect
 end
end