module Redeemable
  extend ActiveSupport::Concern

  included do
    def set_user_fields_for_order
      @order.user_id = @user.id
      @order.firstname = current_user.firstname
      @order.lastname = current_user.lastname
      @order.email = current_user.email
      @total_price = @order.calculate_subtotal
      @before_discount_price = @order.calculate_subtotal
    end

    def redeem_coupon
      @discount_amount = 0.0
      @order.order_items.each do |order_items|
        order_items.product.coupons.each do |coupon|
          coupon.name == params[:coupon] ? coupon_operation(coupon, order_items) : ''
        end
      end
      @total_price = 0.0 if @total_price.negative?
      @order.update_columns(subtotal: @total_price, user_id: @user.id)
    end
  end

  private

  def coupon_operation(coupon, order_items)
    if coupon.redeem_count.positive? && (coupon.validity - Date.today).to_i >= 0
      coupon.value_method == 'amount' ? amount(coupon, order_items) : percentage(coupon, order_items)
      coupon.redeem_count = coupon.redeem_count - 1
      coupon.update_columns(redeem_count: coupon.redeem_count)
    end
  end

  def amount(coupon, order_items)
    @discount_amount += (coupon.value * order_items.quantity)
    @total_price -= (coupon.value * order_items.quantity)
  end

  def percentage(coupon, order_items)
    @discount_amount += (coupon.value * order_items.quantity)
    @total_price -= (@order.calculate_subtotal * (coupon.value * order_items.quantity))
  end
end
