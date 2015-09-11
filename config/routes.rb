Rails.application.routes.draw do
  get 'blog' => 'articles#index'
  resources :articles, except: :index

  root 'welcome#index'
end
