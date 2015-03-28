Rails.application.routes.draw do
  resources :users
  resources :brackets
  
  get '/oauth_callback', to: 'users#oauth_callback'
end
