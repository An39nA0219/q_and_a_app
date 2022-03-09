Rails.application.routes.draw do
  root to: 'questions#index'

  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :questions do
    collection do
      get 'solved', to: 'questions#solved'
      get 'unsolved', to: 'questions#unsolved'
    end
  end
  resources :answers, only: [:create, :destroy]
  resources :question_statuses, only: [:create, :destroy]

  namespace :admins do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :show, :destroy] do
      collection do
        get 'solved', to: 'questions#solved'
        get 'unsolved', to: 'questions#unsolved'
      end
    end
    resources :answers, only: [:destroy]
  end
end
