class OrdersController < ApplicationController
  before_action :set_user, only: %i[new create show index update]
  before_action :set_order, only: %i[show  create update]
  # def index
  # @pagys, @orders = pagy(Order.all, items: Product::PER_PAGE)
  # end
  def new
    if user_signed_in?
    @order = current_order

    @order.firstname = current_user.firstname
    @order.lastname = current_user.firstname
    @order.email = current_user.email
    else
    redirect_to new_user_session_path
    end

  end

  def create

    @order = @order.update(order_params)
    @order.user = @user
    if @order.save
      redirect_to root_path, notice: 'Order was successfully placed'
    else
      render :new
    end
  end

  def update
    @order=current_order
    @order.user_id = @user
    if @order.update(order_params)
      redirect_to root_path, notice: 'Order was successfully placed'
      current_order = nil
      @order =nil
    else
      render :new
    end
  end

  def show

    #@order_item = OrderItem.find(params[:id])
  end
  private
  def set_user
    @user = current_user
  end
  def set_order
    @order = Order.find(params[:id])
  end
  def order_params
    params.require(:order).permit(:email, :firstname , :lastname, :address, :description,:subtotal, :payment_method, :user_id)
  end
end
