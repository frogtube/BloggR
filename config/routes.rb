Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts
  get '/author', to: 'posts#author', as: :author
  
end
