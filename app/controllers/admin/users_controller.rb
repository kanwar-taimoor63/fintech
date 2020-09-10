module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit destroy]
    
    def index
      @users = User.client
      if params[:search].present?
        @users = @users.client.search(params[:search])
        @users = @users.order(sort_column(@users) + ' ' + sort_direction) if sort_column(@users).present? && sort_direction.present?   
      else
        @users = @users.order(sort_column(@users) + ' ' + sort_direction) if sort_column(@users).present? && sort_direction.present?
      end
    end

    def show; end

    def edit; end

    def update; end

    def destroy
      if @user.destroy
        flash[:notice] = 'User has been deleted'
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
      params.require(:user).permit(:firstname, :lastname, :email, :password, :search)
    end
  end
end
