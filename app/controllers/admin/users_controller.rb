module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit destroy]

    def index
      @pagyz, @users = pagy(User.client.search(params[:search]), items: User::PER_PAGE)
      if sort_column(@users).present? && sort_direction.present?
        @pagyz, @users = pagy(@users.order(sort_column(@users) + ' ' + sort_direction), items: User::PER_PAGE)
      end
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
