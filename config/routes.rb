Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tops#home'

  # new_user_path, users_path
  resources :users, only: [:new, :create]

  # login_path
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  # logout_path
  delete 'logout', to: 'user_sessions#destroy', as: :logout
end
