Rails.application.routes.draw do
  root 'products#index'

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :users
      resources :categories
      resources :coupons
      resources :products
    end
  end
  resources :products, only: %i[index show]
  resources :user do
    resources :orders
  end

  get 'policy', to: 'pages#policy'
  get 'home', to: 'pages#home'
  devise_for :users, controllers: { registrations: 'registrations' }
end
