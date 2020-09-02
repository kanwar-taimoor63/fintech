Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  authenticate :user, lambda { |u| u.user_role == User::ROLES[:admin] } do
    namespace :admin do
  	  resources :users
  	end
  end

  #resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
