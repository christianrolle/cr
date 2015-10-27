Rails.application.routes.draw do
  match 'login', to: "user_sessions#new", via: :get
  match 'logout', to: "user_sessions#destroy", via: :get
  root 'articles#index'

  resources :user_sessions, only: :create
  resources :articles, path: 'blog', only: [:index, :show]
  resources :tags, only: :index
  namespace :admin do
    resources :articles, except: :show
    resources :article_tags, only: [:create, :destroy]
  end
end
