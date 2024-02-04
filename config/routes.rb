Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "/about" => "homes#about", as: "about"

  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followed # /users/:id/followed (user(id)がフォローする人の一覧)
      get :follower # /users/:id/follower (user(id)をフォローする人の一覧)
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end