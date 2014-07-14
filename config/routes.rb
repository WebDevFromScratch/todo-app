Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :tasks, except: [:index, :destroy]
  end
end
