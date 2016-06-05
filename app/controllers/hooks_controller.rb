class HooksController < ApplicationController
  def receive
  	data = JSON.parse(request.body.read)
    Webhook::Received.save(data: data, integration: params[:motion_callback])
    render nothing: true
  end
end
