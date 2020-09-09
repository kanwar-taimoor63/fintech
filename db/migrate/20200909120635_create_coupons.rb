class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :name, null: false, unique: true
      t.decimal10 :value, null: false
      t.decimal2 :value, null: false

      t.timestamps
    end
  end
end
