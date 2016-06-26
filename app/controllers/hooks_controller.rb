class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    puts "hello"
  	if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = request.raw_post
    end

    puts data.inspect

  end
	
  def test

  end

end