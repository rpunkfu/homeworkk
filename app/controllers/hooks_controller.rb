class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    if !request.raw_post.nil?
      puts "hello"
    end
  	
    # application/x-www-form-urlencoded
    data = request.raw_post

  end
	
  def test

  end

end