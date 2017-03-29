Rails.application.routes.draw do
  devise_for :authors
  root to: 'posts#index'
  resources :posts
  get '/author', to: 'posts#author', as: :author
  put 'publish', to: 'posts#publish'
  put 'unpublish', to: 'posts#unpublish'
  
end
