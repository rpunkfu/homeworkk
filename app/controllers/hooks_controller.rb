class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include HooksHelper
  
  def receive
    #data = JSON.parse(request.body.read)
    #Webhook::Received.save(data: data, integration: params[:motion_callback])
    #render nothing: true
    post_data = request.body.read
    $req = JSON.parse(post_data)
  end

  def test
  	@req = $req
  end
end