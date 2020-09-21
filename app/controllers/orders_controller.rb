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
    @order.order_items.each do |order_items|
      order_items.product.coupons.each do |coupon|
        next unless coupon.name == params[:coupon]

        next unless coupon.redeem_count.positive? && (coupon.validity - Date.today).to_i >= 0

        coupon.redeem_count = coupon.redeem_count - 1

        if coupon.value_method == 'amount'
          @discount_amount += (coupon.value * order_items.quantity)
          @total_price -= (coupon.value * orderitems.quantity)

        else
          @discount_amount += (coupon.value * order_items.quantity)
          @total_price -= (@order.calculate_subtotal * (coupon.value * order_items.quantity))
        end
        coupon.update_columns(redeem_count: coupon.redeem_count)
      end
    end

    @total_price = 0.0 if @total_price < 0
    @order.update_columns(subtotal: @total_price, user_id: @user.id)
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
