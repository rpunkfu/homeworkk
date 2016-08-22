class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:class_number, :first_name, :last_name, :email, :password, :password_confirmation, :conversation_id)
  end

  def account_update_params
    params.require(:user).permit(:class_number, :first_name, :last_name, :email, :password, :password_confirmation, :current_password, :conversation_id)
  end
  
end