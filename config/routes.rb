Rails.application.routes.draw do
  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :users, only: [:create, :show] do
    resources :tasks, except: [:index, :destroy]
    resources :categories, only: [:new, :create, :show]
  end
end
