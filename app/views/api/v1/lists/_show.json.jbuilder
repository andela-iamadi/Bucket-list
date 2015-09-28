list ||= @list
if list
  json.(list, :id, :name, :created_at, :updated_at)
  json.items list.items, partial: 'api/v1/items/show', as: :item unless list.items.empty?
  json.created_by list.user.full_name
else
  json.error "#{@current_user.full_name} has no such list"
end

# json.items list.items do |item|
#   json.(item, :id, :name)
# end unless list.items.empty?
