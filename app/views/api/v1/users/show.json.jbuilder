if @user
  json.cache! ['v1', @user] do
    json.(@user, :id, :full_name, :email)
    json.items @user.items, partial: 'api/v1/items/show_items', as: :item
    json.date_created @user.created_at
    json.date_updated @user.updated_at
    json.created_by @user.full_name
  end
  if @user.class == ActiveRecord::Base && !@user.persisted? && !@user.valid?
    json.errors @user.errors.messages
  end
else
  json.error "invalid user"
end
# json.cache! ['v1', user], expires_in: 1.minutes do
