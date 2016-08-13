class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'uri'
  
  def receive
    # application/x-www-form-urlencoded
    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)
  end
	
  def test
    if !$webhook_data.nil?
      @webhook = $webhook_data
      @does_user_exist = User.where("conversation_id = ?", @webhook[0][1])

      if 3 > 2
        Messagehuman.message(@webhook[0][1], "Sign up at https://christopherbot.herokuapp.com/?id=#{@webhook[0][1]}")
      end
    end
  end

end