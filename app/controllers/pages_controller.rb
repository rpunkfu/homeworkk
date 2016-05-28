class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'open-uri'

  def home
  	@messageHuman = Messagehuman.data
  end

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    Webhook::Received.save(data: data, integration: params[:motionai])

    render nothing: true
  end
end


 def binurl
@result = open('http://requestb.in/1bzicem1')
@result_lines = @result.lines { |f| f.each_line {|line| p line} }
 end