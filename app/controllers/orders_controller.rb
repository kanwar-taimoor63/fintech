class OrdersController < ApplicationController
  before_action :set_user, only: %i[new create show index update]
  before_action :set_order, only: %i[show create update]
  before_action :authenticate_user!, only: %i[index]
  def index
    @orders = Order.all.where(user_id: current_user)
  end

  def new
    if user_signed_in?
      @order = current_order
      @order.user_id = @user.id
      @before_discount_price = @order.calculate_subtotal
      @total_price = @order.calculate_subtotal

      set_user_fields_for_order
      apply_coupon

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
    @order = begin
                Order.find(params[:id])
             rescue StandardError
               nil
              end
    render_not_found if @order.user_id != current_user.id
  end

  def apply_coupon
    @discount_amount = 0.0
    @order.order_items.each do |ord|
      ord.product.coupons.each do |b|
        if b.name == params[:coupon]
          @discount_amount += (b.value * ord.quantity)
          @total_price -= (b.value * ord.quantity)
        end
      end
    end
    @total_price = 0.0 if @total_price < 0
    @order.update_columns(subtotal: @total_price)
  end

  def set_user_fields_for_order
    @order.firstname = current_user.firstname
    @order.lastname = current_user.lastname
    @order.email = current_user.email
  end

  def order_params
    params.require(:order).permit(:coupon, :email, :firstname, :lastname, :address, :description, :subtotal, :payment_method, :user_id)
  end
end
