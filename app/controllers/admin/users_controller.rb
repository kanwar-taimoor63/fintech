module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: [:show, :edit, :destroy, :update]

    def index
      @users = User.client
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to [:admin, @user], notice: 'User was successfully updated.'
      else
        redirect_to [:admin, @user] , notice: @user.errors
      end
    end

    def destroy
      if @user.destroy
        flash[:notice] = "User has been deleted"
      else
        flash[:alert] = 'Unable to delete user'
      end
      redirect_to admin_users_path
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password)
    end

  end
end
