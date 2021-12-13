Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # ユーザー側のルーティング設定
  scope module: :user do

    root to: "homes#top"
    get "about", to: "homes#about"
    resources :courses do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      collection do
        get :bookmark, :my_course
      end
    end
    resources :users, only: [:edit, :update]

    get 'users/my_page' => 'users#show'

  end

  # 管理者側のルーティング設定
  namespace :admin do
  end
end
