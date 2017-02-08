class ApplicationController < ActionController::Base

  protected
  def set_user_api_token
    RequestStore.store[:my_api_token] = current_user.api_token # or something similar based on `session`
  end

end
