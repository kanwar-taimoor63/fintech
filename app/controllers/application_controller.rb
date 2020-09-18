class ApplicationController < ActionController::Base
  include Pagy::Backend

  include ApplicationHelper

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_users_path : root_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  def render_not_found
    render :file => "../../public/404.html",  :status => 404
  end
  protected

  def configure_permitted_parameters
    permitted_attributes = %i[firstname lastname email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: permitted_attributes
    devise_parameter_sanitizer.permit :account_update, keys: permitted_attributes
  end
end
