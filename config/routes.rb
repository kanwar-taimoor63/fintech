Rails.application.routes.draw do
  root 'pages#home'

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :users
      resources :categories
      resources :coupons
      resources :products
    end
  end

  resources :products, only: %i[index show]
  resources :pages, only: %i[home policy]


  get 'policy', to: 'pages#policy'
  devise_for :users, controllers: { registrations: 'registrations' }
end
