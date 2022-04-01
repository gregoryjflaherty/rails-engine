Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :items do
        resources :find, only: [:index], controller: :search, action: :show
        resources :find_all, only: [:index], controller: :search
      end

      resources :items do
        resources :merchant, only: [:index], controller: :item_merchants, action: :show
      end

      namespace :merchants do
        resources :find, only: [:index], controller: :search, action: :show
        resources :find_all, only: [:index], controller: :search
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :item_merchants
      end
    end
  end
end
