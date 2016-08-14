class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def home
 
  end
  
end
