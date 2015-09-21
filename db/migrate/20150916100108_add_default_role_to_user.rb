class AddDefaultRoleToUser < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "user"
    add_column :users, :items_count, :integer, :default => 0
    add_column :items, :lists_count, :integer, :default => 0
  end
end
