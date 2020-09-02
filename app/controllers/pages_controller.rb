class PagesController < ApplicationController
  def home
  	if current_user && current_user.user_role == User::ROLES[:admin] 
  		redirect_to admin_users_path
  	end
  end
end

