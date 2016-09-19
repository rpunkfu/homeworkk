class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'uri'
  
  def receive

    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)
    @webhook = $webhook_data

  end
	
  def test
     @webhook = $webhook_data # used to inspect the webhook data 
  end

end