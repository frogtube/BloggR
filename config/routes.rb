Rails.application.routes.draw do
  devise_for :authors
  root to: 'posts#index'
  resources :posts
  get '/author', to: 'posts#author', as: :author
  
end
