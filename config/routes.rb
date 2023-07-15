Rails.application.routes.draw do
  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    root :to => "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    resources :categories, only: [:index, :create, :edit, :update]
  end
  #ユーザー用
  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: "followings"
      get 'followers' => 'relationships#followers', as: "followers"
    end
    get "check" => "users#check"
    patch "withdrawal" => "users#withdrawal"
    resources :reviews do
      resources :comments, only: [:create, :destroy]
    end
    #絞り込み表示用の画面表示
    get "reviews/mouse" => "reviews#mouse"
    get "reviews/keyboard" => "reviews#keyboard"
    get "reviews/mousepad" => "reviews#mousepad"
    get "reviews/headset" => "reviews#headset"
    get "reviews/monitor" => "reviews#monitor"
    get "search" => "searches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
