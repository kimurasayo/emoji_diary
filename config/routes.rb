Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tops#home'

  # new_user_path, users_path
  # user_diaries_path(index), new_user_diary_path, edit_user_diary, user_diary(show)
  resources :users, only: [:new, :create, :index] do
    resources :diaries
  end

  resources :relationships, only: [:create, :destroy]

  # login_path
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  # logout_path
  delete 'logout', to: 'user_sessions#destroy', as: :logout
end
