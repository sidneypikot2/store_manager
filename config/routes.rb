Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[index show]
  resources :carts, only: %i[create index destroy]
  resources :checkouts, only: %i[create index show]

  namespace :admin do
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
end
