Rails.application.routes.draw do
  resources :cart_items
  resources :user_items
  resources :carts
  resources :items
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
