Rails.application.routes.draw do

  # get "/api/v1/users/:user_id/items" => "api/v1/items#index", as: :user_items
  # get "/api/v1/users/:user_id/items/:id" => "api/v1/items#show", as: :user_item
  #
  post "/api/v1/auth/login" => "api/v1/auth#login"
  get "/api/v1/auth/logout" => "api/v1/auth#logout"

  get "/api/v1/bucketlists" => "api/v1/items#index"
  post "/api/v1/bucketlists" => "api/v1/items#create"
  get "/api/v1/bucketlists/:id" => "api/v1/items#show"
  post "/api/v1/bucketlists/:id" => "api/v1/list#create"
  put "/api/v1/bucketlists/:id" => "api/v1/list#update"
  patch "/api/v1/bucketlists/:id" => "api/v1/list#update"
  delete "/api/v1/bucketlists/:id" => "api/v1/list#delete"
  delete "/api/v1/bucketlists/:id/item/:id" => "api/v1/list#delete"


  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :items do
        resources :lists
      end
    end
  end
end

# POST /auth/login => Logs a user in
# GET /auth/logout => Logs a user out
# POST /bucketlists/ => Create a new bucket list
# GET /bucketlists/ => List all the created bucket lists
# GET /bucketlists/<id> => Get single bucket list
# POST /bucketlists/<id> => Add a new item to this bucket list
# PUT /bucketlists/<id> => Update this bucket list
# DELETE /bucketlists/<id>
