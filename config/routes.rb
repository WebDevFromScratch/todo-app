Rails.application.routes.draw do
  get '/register', to: 'users#new'

  resources :users, only: [:create, :show] do
    resources :tasks, except: [:index, :destroy]
    resources :categories, only: [:new, :create, :show]
  end
end
