class AddColToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :expiry_date, :date
    add_column :products, :discount_price, :decimal, precision: 10, scale: 2
  end
end
