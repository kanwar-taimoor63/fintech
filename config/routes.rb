Rails.application.routes.draw do
  resources :pages, only: %i[home policy]
  root 'pages#home'

  authenticate :user, lambda { |user| user.admin? } do
    namespace :admin do
  	  resources :users
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'policy', to: 'pages#policy'
  devise_for :users, controllers: { registrations: 'registrations' }
end
