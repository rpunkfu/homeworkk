class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'uri'
  
  def receive
    respond_to do |format|
      msg = { :value1 => "alec", :value2 => "jones" }
      format.json  { render :json => msg } # don't do msg.to_json
    end

    # application/x-www-form-urlencoded
    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)
    @webhook = $webhook_data

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