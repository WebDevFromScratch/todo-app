Rails.application.routes.draw do
  root to: 'sessions#new'
  post '/', to: 'sessions#create'

  get '/register', to: 'users#new'

  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:create, :show] do
    resources :tasks, except: [:index]
    resources :categories, only: [:new, :create, :show]
  end
end
