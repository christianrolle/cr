Rails.application.routes.draw do
  resources :articles, path: 'blog', only: [:index, :show]

  root 'welcome#index'
end
