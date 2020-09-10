class CreateJoinTableCouponsProducts < ActiveRecord::Migration[5.2]
  def change
    create_join_table :coupons, :products do |t|
      t.references  :coupons, index: true, foreign_key: true
      t.references  :products, index: true, foreign_key: true
    end
  end
end
