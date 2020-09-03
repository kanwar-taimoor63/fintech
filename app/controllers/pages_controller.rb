class PagesController < ApplicationController
  def home
    if current_user && current_user.admin?
  	  redirect_to admin_users_path
  	end
  end
end

