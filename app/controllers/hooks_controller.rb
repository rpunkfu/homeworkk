class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'uri'
  
  def receive
    # application/x-www-form-urlencoded
    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)

    if 3 > 2
      @webhook = $webhook_data
      #$doesUserExist = User.where("conversation_id = ?", @webhook[0][1])
      Messagehuman.message(@webhook[0][1], "Sign up here")
    end
  end
	
  def test
     @webhook = $webhook_data # used to inspect the webhook data 
     
  end

end