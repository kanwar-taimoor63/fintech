class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :destroy]
  def index
    @users = User.client
  end

  def show; end

  def edit; end

  def update; end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "User has been deleted"
    else
      flash.now[:alert] = 'Unable to delete user'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
