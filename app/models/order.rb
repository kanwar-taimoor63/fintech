class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
    PER_PAGE=1
  def self.search(search)
    return all if search.blank?
    where('orders.id LIKE ? OR orders.email LIKE ? OR orders.firstname LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def calculate_subtotal
    order_items.collect {|order_item| order_item.valid? ? (order_item.unit_price*order_item.quantity) : 0}.sum
  end
end
