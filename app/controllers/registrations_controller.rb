class RegistrationsController < Devise::RegistrationsController
	def edit
  	@timeZones = [["Pacific Time", -8], ["Mountain", -7],["Central Time", -6],["Eastern Time", -5],["Atlantic Time", -4]] 
  end
  private

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up_params
    params.require(:user).permit(:class_number, :first_name, :last_name, :email, :password, :password_confirmation, :conversation_id, :time_zone)
  end

  def account_update_params
    params.require(:user).permit(:class_number, :first_name, :last_name, :email, :conversation_id, :time_zone)
  end
  
end