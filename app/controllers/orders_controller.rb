class OrdersController < ApplicationController
  before_action :set_user, only: %i[new create show index update]
  before_action :set_order, only: %i[show create update]
  before_action :authenticate_user!, only: %i[index]
  include Redeemable

  def index
    @pagys, @orders = pagy(Order.where(user_id: current_user).search(params[:search]), items: Order::PER_PAGE)
  end

  def new
    if user_signed_in?
      @order = current_order
      set_user_fields_for_order
      redeem_coupon
      render 'new'
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @order = @order.update(order_params)
    if @order.save
      redirect_to root_path, notice: 'Order was successfully placed'
    else
      render :new
    end
  end

  def update
    @order.user_id = current_user.id
    if @order.update!(order_params)
      session[:order_id] = nil
      render :show
    else
      render :new
    end
  end

  def show; end

  private

  def set_user
    @user = current_user
  end

  def set_order
    @order = Order.find(params[:id])
    render_not_found if @order.user_id != current_user.id
  end

  def order_params
    params.require(:order).permit(:coupon, :email, :firstname, :lastname, :address, :description, :subtotal, :payment_method, :user_id)
  end
end
