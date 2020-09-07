class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    resource.admin ? admin_users_path  : root_path
  end
end
