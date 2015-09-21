if @item
  json.cache! ['v1', @item] do
    json.(@item, :id, :full_name, :email)
    json.items @items do |item|
    json.items @item.items, partial: 'api/v1/items/list_items', as: :item
  end
  if @item.class == ActiveRecord::Base && !@item.persisted? && !@item.valid?
    json.errors @item.errors.messages
  end
else
  json.error "invalid item"
end
