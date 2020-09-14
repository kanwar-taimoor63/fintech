class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :description
      t.string :payment_method

      t.timestamps
    end
  end
end
