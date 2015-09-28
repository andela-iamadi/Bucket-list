Rails.application.routes.draw do

  # get "/api/v1/users/:user_id/lists" => "api/v1/lists#index", as: :user_lists
  # get "/api/v1/users/:user_id/lists/:id" => "api/v1/lists#show", as: :user_list
  #
  post "/api/v1/auth/login" => "api/v1/auth#login"
  get "/api/v1/auth/logout" => "api/v1/auth#logout"


  # get "/api/v1/users" => "api/v1/users#index", as: :api_v1_users
  get "/api/v1/users" => "api/v1/users#show", as: :api_v1_users, defaults: {format: 'json'}
  # post "/api/v1/users" => "api/v1/users#create", defaults: {format: 'json'}
  patch "/api/v1/users" => "api/v1/users#update", as: :edit_api_v1_user, defaults: {format: 'json'}
  put "/api/v1/users" => "api/v1/users#update", defaults: {format: 'json'}
  delete "/api/v1/users" => "api/v1/users#delete", defaults: {format: 'json'}

  get "/api/v1/bucketlists" => "api/v1/lists#index"
  post "/api/v1/bucketlists" => "api/v1/lists#create"
  get "/api/v1/bucketlists/:id" => "api/v1/lists#show"
  post "/api/v1/bucketlists/:id" => "api/v1/item#create"
  put "/api/v1/bucketlists/:id" => "api/v1/item#update"
  patch "/api/v1/bucketlists/:id" => "api/v1/item#update"
  delete "/api/v1/bucketlists/:id" => "api/v1/item#delete"
  delete "/api/v1/bucketlists/:id/list/:id" => "api/v1/item#delete"

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:index, :create]
      resources :lists do
        resources :items
      end
    end
  end

  # error handlers for this sweet API
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "api/v1/errors#show", :code => code
  end
  match '*a', :to => 'api/v1/errors#not_found', via: [:get, :post, :put, :patch, :delete, :copy]
  get "api/v1/not_found" => "api/v1/errors/not_found", as: :api_v1_not_found_errors
  get "api/v1/server_error" => "api/v1/errors/server_error", as: :api_v1_server_errors

end
