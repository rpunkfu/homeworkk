class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
		puts "hello"
		request
  	if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end
    #puts data

    Webhook::Received.save(data: data, integration: params[:motion_callback])
    render nothing: true

	end
	
end