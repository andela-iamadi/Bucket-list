if @lists && !@lists.empty?
  json.cache! ['v1', @lists] do
    json.lists @lists, partial: 'api/v1/lists/show', as: :list
  end
  if @list.class == ActiveRecord::Base && !@list.persisted? && !@list.valid?
    json.errors @list.errors.messages
  end
else
  json.error "invalid list"
end
