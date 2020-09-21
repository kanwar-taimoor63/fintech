Rails.application.routes.draw do
  root 'products#index'

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :users
      resources :categories
      resources :coupons
      resources :products
      resources :subscriptions, only: %i[index show destroy]
    end
  end

  resources :products, only: %i[index show]
  resources :order_items
  resource :carts, only: [:show]
  resources :orders
  get 'policy', to: 'pages#policy'
  devise_for :users, controllers: { registrations: 'registrations' }
end
