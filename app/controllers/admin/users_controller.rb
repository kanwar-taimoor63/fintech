module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: [:show, :edit, :destroy]

    def index
      @users = User.client
    end

    def show; end

    def edit; end

    def update; end

    def destroy
      if @user.destroy
        flash[:notice] = "User has been deleted"
        @message = flash[:notice]
      else
        flash[:alert] = 'Unable to delete user'
        @message = flash[:alert]
      end
      redirect_to admin_users_path, message: @message
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
