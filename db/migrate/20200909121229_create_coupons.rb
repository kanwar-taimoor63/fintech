class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :name,null: false, unique: true
      t.decimal :value, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
