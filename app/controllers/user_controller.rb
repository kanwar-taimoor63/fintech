class UserController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = begin
              User.find(current_user.id)
            rescue StandardError
              nil
            end
  end

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:firstname, :lastname, :email)
    else
      params.require(:user).permit(:firstname, :lastname, :email, :password)
    end
  end
end
