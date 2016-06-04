class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
      data = JSON.parse(request.body.read)

    Webhook::Received.save(data: data, integration: params[:motion_callback])

    render nothing: true
  end

end