class ChangeColumnInItems < ActiveRecord::Migration
  def change
    rename_column :items, :lists_id, :list_id
  end
end
