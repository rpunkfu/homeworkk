class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    # application/x-www-form-urlencoded
    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)
  end
	
  def 
    # write if statement for if the variable is set
    @test = $webhook_data[0][1]
  end

end