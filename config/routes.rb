Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tops#home'

  # new_user_path, users_path
  # user_followers_path
  # user_diaries_path(index), new_user_diary_path, edit_user_diary, user_diary(show)
  # user_bookmarks_path
  resources :users, only: [:new, :create, :index, :destroy] do
    resources :followers, only: [:index]

    resources :diaries do
      member do
        resources :bookmarks, only: [:index]
      end
    end
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

  get 'following', to: 'users#following'
  get 'follower', to: 'users#follower'
  get 'search', to: 'users#search'
end
