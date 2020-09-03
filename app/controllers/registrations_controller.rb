class RegistrationsController < Devise::RegistrationsController
  before_action :validate_signin, only: :create

  private

  def validate_signin
    build_resource(sign_up_params)
    return render 'devise/sessions/new' unless resource.valid?
  end
end
