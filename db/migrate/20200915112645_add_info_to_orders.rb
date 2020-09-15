class AddInfoToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :description, :text
    add_column :orders, :payment_method, :string, default: "", null: false
    add_column :orders, :firstname, :string, default: "", null: false
    add_column :orders, :lastname, :string, default: "", null: false
    add_column :orders, :email, :string, default: "", null: false
    add_column :orders, :address, :text
  end
end
