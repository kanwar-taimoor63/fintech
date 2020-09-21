module Admin
  class SubscriptionsController < BaseController
    before_action :set_order, only: %i[show destroy]
    def index
      @orders = Order.all
    end

    def show;end

    def destroy
      if @order.destroy
        flash[:notice] = 'Order has been deleted'
      else
        flash[:alert] = 'Unable to delete order'
      end
      redirect_to admin_subscriptions_path
    end

    private

    def set_order
      @order =  begin
                  Order.find(params[:id])
                  rescue StandardError
                  nil
                end
    end
  end
end
