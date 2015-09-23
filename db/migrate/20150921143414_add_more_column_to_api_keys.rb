class AddMoreColumnToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :expires_at, :datetime
    add_column :api_keys, :active, :boolean

    add_index :api_keys, :user_id, name: "index_api_keys_on_user_id", unique: false
    add_index :api_keys, :token, name: "index_api_keys_on_token", unique: true
  end
end
