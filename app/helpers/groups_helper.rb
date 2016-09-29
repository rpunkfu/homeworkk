module GroupsHelper
	def resource_name
    :user
  end

  def resource
  	if user_signed_in?
  		@resource ||= User.where("uid = ?", current_user.id)
  	end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
