class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :set_webhook_variable

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

    if !data.nil? 
      @webhook_variable = data
      $set_variable_true = 1
    end

	end
	
  def test
    if !@webhook_variable.nil?
      @data = @webhook_variable
    end
  end

  private

  def set_webhook_variable
    if !$set_variable_true.nil?
      @webhook_variable = data
    end
  end
end