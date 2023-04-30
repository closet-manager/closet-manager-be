Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:show] do
        get '/items/find_all', to: 'items/search#show'
        resources :items, only: [:show, :create, :update, :index, :destroy]
        resources :lists, only: [:index, :show, :create, :destroy] do
          resources :items, only: [:index], controller: :list_items
        end
      end
      resources :items, only: [] do
        resources :lists, only: [:destroy], controller: :list_items do
          resources :list_items, only: [:create]
        end
      end
      resources :events, only: [:create] 
    end
  end
  # get '*other', to: 'home#index'
end
