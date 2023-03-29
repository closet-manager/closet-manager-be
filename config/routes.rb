Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:show] do
        get '/items/find_all', to: 'items/search#show'
        resources :items, only: [:show, :create]
        resources :lists, only: [:index]
      end
    end
  end
end
