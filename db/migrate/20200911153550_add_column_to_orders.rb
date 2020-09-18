class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :firstname, :string, null: false, default: ''
    add_column :orders, :lastname, :string, null: false, default: ''
    add_column :orders, :email, :string, null: false, default: ''
    add_column :orders, :address, :text
    add_column :orders, :number, :string, null: false, default: ''
  end
end
