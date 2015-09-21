
json.(item, :id, :name)
json.lists item.lists, partial: 'api/v1/lists/show_list', as: :list
#
# json.lists item.lists do |list|
#   json.(list, :id, :name)
# end unless item.lists.empty?
