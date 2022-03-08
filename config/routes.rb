Rails.application.routes.draw do
  root to: 'questions#index'

  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :questions
  resources :answers, only: [:create, :update, :destroy]
  resources :question_statuses, only: [:create, :destroy]

  namespace :admins do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :show, :destroy]
    resources :answers, only: [:destroy]
  end
end
