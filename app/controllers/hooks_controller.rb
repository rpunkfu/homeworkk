class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    # application/x-www-form-urlencoded
    data = request.raw_post
    raw_webhook_data = data
    $webhook_data = URI::decode_www_form(raw_webhook_data)
  end
	
  def test
    @test = $webhook_data
  end

end