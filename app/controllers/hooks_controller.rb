class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    # application/x-www-form-urlencoded
    data = request.raw_post
    $DATA = data
  end
	
  def test
    @test = $DATA
  end

end