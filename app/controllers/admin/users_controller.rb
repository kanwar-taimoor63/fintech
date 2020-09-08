module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: [:show, :edit, :destroy]

    def index
      @users = User.client
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params.merge(confirmed_at: Time.zone.now, password: User::TEMP_PASSWORD))
      if @user.save
        redirect_to admin_users_path, notice: "User added"
        @user.invite
      else
        render :new
      end
    end

    def edit; end

    def update; end

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
