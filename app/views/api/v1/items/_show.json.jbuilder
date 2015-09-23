item ||= @item
if item
  json.(item, :id, :name, :created_at, :updated_at)
  json.lists item.lists, partial: 'api/v1/lists/show_lists', as: :list unless item.lists.empty?
  json.created_by item.user.full_name
else
  json.error "item doesn't exist"
end

# json.lists item.lists do |list|
#   json.(list, :id, :name)
# end unless item.lists.empty?
