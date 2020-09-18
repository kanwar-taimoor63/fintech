class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false, unique: true
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
