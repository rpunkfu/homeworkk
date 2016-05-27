class PagesController < ApplicationController
  def home
  	@messageHuman = Messagehuman.data
  end
end
