class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  def calculate_subtotal
    order_items.collect {|order_item| order_item.valid? ? (order_item.unit_price*order_item.quantity) : 0}.sum
  end
end
