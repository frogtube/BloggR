Rails.application.routes.draw do
  root to: 'read/posts#index'

  namespace :author do
      resources :posts
  end

  scope module: 'read' do
    get 'posts', to: 'posts#index', as: :posts
    get 'posts/id', to: 'posts#show', as: :post 
  end
  
end
