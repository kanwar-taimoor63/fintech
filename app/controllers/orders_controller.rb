class OrdersController < ApplicationController
  before_action :set_user, only: %i[new create show index]
  before_action :set_order, only: %i[show]

  def index; end

  def new
    @order = Order.new
    @order.firstname = current_user.firstname
    @order.lastname = current_user.firstname
    @order.email = current_user.email
  end

  def create
    @order = Order.new(order_params)
    @order.user = @user

    if @order.save
      redirect_to root_path, notice: 'Order was successfully placed'
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
  end

  def order_params
    params.require(:order).permit(:email, :firstname, :lastname, :address, :description, :payment_method, :user_id)
  end
end
