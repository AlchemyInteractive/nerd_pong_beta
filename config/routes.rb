Rails.application.routes.draw do
  root 'sessions#index'
  resources :users
  resources :brackets

  get '/auth/twitter/callback', to: 'sessions#create'
  post '/save_score', to: 'games#save_score'

end
