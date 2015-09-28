item ||= @item
if item
  json.(item, :id, :name, :created_at, :updated_at)
  json.list item.list.name
else
  json.error "item doesn't exist"
end

# json.items item.items do |item|
#   json.(item, :id, :name)
# end unless item.items.empty?
