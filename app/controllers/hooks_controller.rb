class HooksController < ApplicationController
  before_filter :set_webhook_variable
  skip_before_filter :verify_authenticity_token
  
  def tester
    @number = 123
  end

  def receive
    puts "hello"
    puts request
  	if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    Webhook::Received.save(data: data, integration: params[:motion_callback])
    render nothing: true

    @dataArray.push(data)
  end
	
  def test
    @test = @dataArray
  end

  private

  def set_webhook_variable
    @dataArray = Array.new
  end
end