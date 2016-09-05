class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  require 'uri'
  
  def receive
    # application/x-www-form-urlencoded
    data = request.raw_post
    $webhook_data = URI::decode_www_form(data)

    if !$webhook_data.nil?
=begin
      @webhook = $webhook_data
      $doesUserExist = User.where("conversation_id = ?", @webhook[0][1])

      if $doesUserExist.empty?
       Messagehuman.message(@webhook[0][1], "Sign up at https://christopherbot.herokuapp.com/users/sign_in?conversation_id=#{@webhook[0][1]}")
      end
    end
=end
  uri = URI($webhook[0][1])
  req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  req.body = {value1: 'alecjones', value2: 'mr.awesome'}.to_json
  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end
  end
	
  def test
     @webhook = $webhook_data # used to inspect the webhook data 
  end

end