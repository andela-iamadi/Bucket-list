Rails.application.routes.draw do

  get "/api/v1/users/:user_id/items" => "api/v1/items#index", as: :user_items

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users do
        resource :items do
          resources :lists
        end
      end
    end
  end
end
