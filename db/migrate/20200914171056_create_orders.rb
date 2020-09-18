class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 10, scale: 2
      t.string :firstname,  null: false, default: ''
      t.string :lastname,  null: false, default: ''
      t.string :email,  null: false, default: ''
      t.text :address 
      t.string :payment_method,  null: false, default: ''
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false  
      end
    add_reference :orders, :user, foreign_key: true
  end
end
