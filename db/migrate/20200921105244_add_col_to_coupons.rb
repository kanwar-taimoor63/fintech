class AddColToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :redeem_count, :integer, default: 1, null: false
    add_column :coupons, :validity, :date, null: false
    add_column :coupons, :value_method, :string, null: false, default: ''
  end
end
