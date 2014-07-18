Rails.application.routes.draw do
  root to: 'sessions#new'
  post '/', to: 'sessions#create'
  get '/date_before', to: 'sessions#date_before'
  get '/date_after', to: 'sessions#date_after'

  get '/register', to: 'users#new'

  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :destroy] do
    resources :tasks, except: [:index] do
      patch '/accomplished', to: 'tasks#accomplished'
    end
    get '/my_categories', to: 'users#show_categories'
    post '/add_category', to: 'users#add_category'
    post 'remove_category', to: 'users#remove_category'

    resources :categories, only: [:show]
  end

  resources :categories, only: [:new, :create]
end
