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
  resource :carts, only: %i[show]
  resources :orders
  resource :user, only: %i[show edit update]
  get 'policy', to: 'pages#policy'
  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index]
    end
    namespace :v2 do
      post :auth, to: 'authentication#create'
      resources :products, only: %i[index]
    end
    get '/*a', to: 'pages#error_404', via: :all
  end

  match '*path', to: 'pages#error_404', via: :all
end
