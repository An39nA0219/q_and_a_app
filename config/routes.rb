Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update]
end
