Rails.application.routes.draw do
  root 'pages#home'
  get '/salut/:name', to: 'pages#salut'
end
