class RegistrationsController < Devise::RegistrationsController
	def edit
  	@timeZones = [["Pacific Time", -8], ["Mountain", -7],["Central Time", -6],["Eastern Time", -5],["Atlantic Time", -4]] 
    @userTimeZone = current_user.time_zone.to_i.freeze
    $timeZoneParam = params
  end

  def destroy
    @user = User.find(current_user.id)
    @user.groups.each do |group| 
      @group = Group.find_by(id: group.id)
      @group.destroy
    end
    $sentWelcome.delete(@user.conversation_id)
    @user.destroy

    if @user.destroy
      redirect_to root_url, notice: "Your account has been successfully, terminated."
    end
  end
  private

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up_params
    params.require(:user).permit(:class_number, :first_name, :last_name, :email, :password, :password_confirmation, :conversation_id, :time_zone)
  end

  def account_update_params
    params.require(:user).permit(:class_number, :first_name, :last_name, :email, :time_zone)
  end
  
end