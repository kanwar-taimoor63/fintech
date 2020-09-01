class AddConstraintsToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :username, :string, default: ""
  end
end
