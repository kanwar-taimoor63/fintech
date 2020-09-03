class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  def index
    @users = User.all.where(user_role: User::ROLES[:client])
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "User has been deleted"
    else
      redirect_to admin_users_path, notice: "Unable to delete user"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
