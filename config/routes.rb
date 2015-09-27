Rails.application.routes.draw do
  devise_for :users
  resources :articles, path: 'blog', only: [:index, :show]

  root 'welcome#index'
end
