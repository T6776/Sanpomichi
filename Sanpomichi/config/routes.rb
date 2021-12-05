Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  # ユーザー側のルーティング設定
  root to: "user/homes#top"
  get "about", to: "user/homes#about"
  resources :courses

  # 管理者側のルーティング設定
  namespace :admin do
  end
end
