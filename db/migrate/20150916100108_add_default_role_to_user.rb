class AddDefaultRoleToUser < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "user"
    add_column :users, :lists_count, :integer, :default => 0
    add_column :lists, :items_count, :integer, :default => 0
  end
end
