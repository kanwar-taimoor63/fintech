class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.decimal :unit_price, precision: 10, scale: 2
      t.integer :quantity
      t.decimal :total_price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
