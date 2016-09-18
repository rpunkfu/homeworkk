class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'uri'
  
  def receive

    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)
    @webhook = $webhook_data

    respond_to do |format|
      msg = { "subject": "math" }
      format.json  { render :json => msg, :content_type => 'application/json' } # don't do msg.to_json
    end
=begin
    if !$webhook_data.nil?
      $doesUserExist = User.where("conversation_id = ?", @webhook[0][1])

      if $doesUserExist.empty?
       Messagehuman.message(@webhook[0][1], "Sign up at https://christopherbot.herokuapp.com/users/sign_in?conversation_id=#{@webhook[0][1]}")
      end
    end
=end
  end
	
  def test
     @webhook = $webhook_data # used to inspect the webhook data 
  end

end