module Admin
  class UsersController < Admin::BaseController

    before_action :set_user, only: %i[show edit destroy]


    def index
      @pagyz, @users = pagy(User.client, items: 5)
      if params[:search].present?
        @pagyz, @users = pagy(@users.search(params[:search]),items: 5)
        @pagyz, @users = pagy(@users.order(sort_column(@users) + ' ' + sort_direction), items: 5) if sort_column(@users).present? && sort_direction.present?
      else
        @pagyz, @users = pagy(@users.order(sort_column(@users) + ' ' + sort_direction), items: 5) if sort_column(@users).present? && sort_direction.present?
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
