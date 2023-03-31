Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:show] do
        get '/items/find_all', to: 'items/search#show'
        resources :items, only: [:show, :create, :update, :index]
        resources :lists, only: [:index, :show, :create]
        # resources :list_items, only: [:destroy]
      end
      resources :items, only: [] do
        resources :lists, only: [:destroy], controller: :list_items do
          resources :list_items, only: [:create]
        end
      end
    end
  end
end
