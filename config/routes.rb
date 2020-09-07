Rails.application.routes.draw do
  resources :pages, only: %i[home policy]
  root 'pages#home'
  get 'policy', to: 'pages#policy'
  devise_for :users, controllers: { registrations: 'registrations' }
end
