Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tops#home'
  get 'privacy', to: 'tops#privacy'
  get 'uses', to: 'tops#uses'
  get 'line', to: 'tops#line'
  get 'index', to: 'tops#index'

  # ユーザーのパスには:nameが入るようにしてあります
  resources :users, param: :name, only: [:new, :create, :index, :destroy] do
    resources :followers, only: [:index]

    get 'following', to: 'users#following'
    get 'follower', to: 'users#follower'

    resources :diaries
  end

  resources :relationships, only: [:create, :destroy]

  resources :bookmarks, only: [:create, :destroy]

  # profiles_path, edit_profiles_path
  resource :profiles, only: [:show, :edit, :update]

  # login_path
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  # logout_path
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  get 'search', to: 'users#search'

  # linebot
  post '/callback', to: 'linebot#callback' 

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :contacts, only: [:new, :create]

  post 'guest', to: 'guest_sessions#create'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
