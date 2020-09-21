module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @pagy, @users = pagy(User.client.search(params[:search]), items: User::PER_PAGE)
      if sort_column(@users).present? && sort_direction.present?
        @pagy, @users = pagy(@users.order(sort_column(@users) + ' ' + sort_direction), items: User::PER_PAGE)
      end

      respond_to do |format|
        format.html
        format.csv { send_data User.all.to_csv, filename: "users-#{Date.today}.csv" }
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

    def update
      if @user.update!(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        redirect_to [:admin, @user] , notice: @user.errors
      end
    end

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
      @user = begin
                User.find(current_user.id)
              rescue StandardError
                nil
              end
    end

    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:firstname, :lastname, :email, :search)
      else
        params.require(:user).permit(:firstname, :lastname, :email, :password, :search)
      end
    end
  end
end
