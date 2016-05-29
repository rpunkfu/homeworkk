class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'open-uri'

  def home
  	@messageHuman = Messagehuman.data
  end
end
