module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit destroy]
    helper_method :sort_column, :sort_direction

    def index
      return @users = User.search(params[:search]) if params[:search]

      @users = if sort_column && sort_direction
                 User.order(sort_column + ' ' + sort_direction)
               else
                 User.search(params[:search])
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

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'username'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :search)
    end
  end
end
