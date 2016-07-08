class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def home
  	#@messageHuman = Messagehuman.data
  	@test1 = request.env["omniauth.params"]
  	@test2 = request.env["rack.session"]["omniauth.origin"]
  	@test3 = request.env["omniauth.origin"]
  	@test4 = request.env["omniauth.auth"]
  	@test5 = session["devise.facebook_data"]
  	@test6 = session["facebook_data"]
    @test7 = env["omnauth.auth"]
  end
  
end
