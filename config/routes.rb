Rails.application.routes.draw do

  get 'group/index'
  get 'group/show'
  get 'group/edit'
  get 'group_users/create'
  get 'group_users/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "about" => "homes#about", as: "about"
  get "search" => "searches#search"
  get "search_date" => "searches#search_date"

  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
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
    resources :event_mails, only: [:new, :create, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end