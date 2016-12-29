module PagesHelper
	def resource_name
    :user
  end

  def resource
   
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
