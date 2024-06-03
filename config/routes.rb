Rails.application.routes.draw do
  root 'pages#index' 
  get 'login', to: 'pages#login'
  get 'signup', to: 'pages#signup' 
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'

  resources :tasks do
    collection do
    end

    # member do
    # end
  end
end
