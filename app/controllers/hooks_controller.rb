class HooksController < ApplicationController
  before_filter :set_webhook_variable
  before_filter :receive
  skip_before_filter :verify_authenticity_token

  def receive
    puts "hello"
    puts request
  	if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    puts data
    
    @dataArray.push("data: ", data)
  end
	
  def test
    @test = @dataArray
  end

  private

  def set_webhook_variable
    @dataArray = Array.new
  end
end