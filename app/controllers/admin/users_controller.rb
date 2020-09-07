module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit destroy]

    def index
      @filterrific = initialize_filterrific(
        User.client,
        params[:filterrific],
        select_options: { sorted_by: User.options_for_sorted_by }
      ) || return
      @users = @filterrific.find.page(params[:page])
      respond_to do |format|
        format.html
        format.js
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to(reset_filterrific_url(format: :html)) && return
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
  end
end
