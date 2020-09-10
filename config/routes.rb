Rails.application.routes.draw do
  resources :pages, only: %i[home policy]
  root 'pages#home'

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :users
      resources :categories
      resources :coupons
      resources :products
    end
  end

  get 'policy', to: 'pages#policy'
  devise_for :users, controllers: { registrations: 'registrations' }
end
