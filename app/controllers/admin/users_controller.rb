class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, :notice => "User has been deleted"
  end
end
