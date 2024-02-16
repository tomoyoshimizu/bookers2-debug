Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"

  get "about" => "homes#about", as: "about"

  get "search" => "searches#search"
  get "search_date" => "searches#search_date"
  get "search_tag" => "searches#search_tag"

  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get "sorts" => "sorts#sort"
    end
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    resources :direct_messages, only: [:index ,:create, :destroy]
    member do
      get :following # /users/:id/following (user(id)のフォローユーザーの一覧)
      get :follower # /users/:id/follower (user(id)のフォロワーの一覧)
    end
  end
  resources :groups do
    resources :group_users, only: [:create, :destroy]
    resources :event_mails, only: [:new, :create]
    get "event_mails" => "event_mails#sent"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end