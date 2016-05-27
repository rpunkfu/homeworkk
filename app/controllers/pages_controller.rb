class PagesController < ApplicationController
  def home
  	@messageHuman = Messagehuman.message
  end
end
