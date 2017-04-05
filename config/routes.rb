Rails.application.routes.draw do
  devise_for :authors
  root to: 'posts#index'
  resources :posts
  get '/author', to: 'posts#author', as: :author
  put 'publish', to: 'posts#publish'
  put 'unpublish', to: 'posts#unpublish'

  get '/account', to: 'accounts#edit', as: :account
  put '/update_info', to: 'accounts#update_info', as: :update_info_account
  put '/change_password', to: 'accounts#change_password', as: :change_password_account
  
end
