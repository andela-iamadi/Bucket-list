if @items && !@items.empty?
json.cache! ['v1', @items] do
    json.items @items, partial: 'api/v1/items/show', as: :item
  end
  if @item.class == ActiveRecord::Base && !@item.persisted? && !@item.valid?
    json.errors @item.errors.messages
  end
else
  json.error "invalid item"
end
