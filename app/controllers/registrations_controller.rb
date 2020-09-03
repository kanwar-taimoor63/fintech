class RegistrationsController < Devise::RegistrationsController
# POST /resource
  def create
    build_resource(sign_up_params)
    unless resource.save
      render 'devise/sessions/new'
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      $signup_form_toggle_flag = false
      clean_up_passwords resource
      set_minimum_password_length
    end
  end
end
