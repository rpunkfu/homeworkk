class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    raise request.env["omniauth.auth"].to_yaml
  end

  def failure
    redirect_to root_path
  end
end