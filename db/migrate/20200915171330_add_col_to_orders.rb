class AddColToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :subtotal, :decimal, precision: 10, scale: 2
  end
end
