module Api::V1
  class OrdersController < BaseController

    def index
      @orders = Order.where(user_id: current_user).search(params[:search])
      render json: @orders
    end

  end
end
