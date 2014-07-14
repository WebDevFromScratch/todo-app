Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :tasks, except: [:destroy]
  end
end
