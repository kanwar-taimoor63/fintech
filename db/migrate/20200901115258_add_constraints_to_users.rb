class AddConstraintsToUsers < ActiveRecord::Migration[5.2]
  def change
  	reversible do |dir|
    dir.up do
      change_column :users, :username, :string, null: true, default: ''
      change_column :users, :firstname, :string, null: false, default: ''
      change_column :users, :lastname, :string, null: false, default: ''
    end
    dir.down do
      change_column :users, :username, :string
      change_column :users, :firstname, :string
      change_column :users, :lastname, :string
    end
  end
    
  end
end
