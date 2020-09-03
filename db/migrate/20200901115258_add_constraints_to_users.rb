class AddConstraintsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :username, :string, null: true, default: ""
    change_column :users, :firstname, :string, null:false, default: ""
    change_column :users, :lastname, :string, null:false, default: ""
  end
end
