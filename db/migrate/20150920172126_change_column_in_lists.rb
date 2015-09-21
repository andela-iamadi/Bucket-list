class ChangeColumnInLists < ActiveRecord::Migration
  def change
    rename_column :lists, :items_id, :item_id
  end
end
