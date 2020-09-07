class AddRoleAttributeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, default: User::ROLES[:client]
  end
end
