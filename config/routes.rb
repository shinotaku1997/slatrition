Rails.application.routes.draw do
  root "stractic_pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  get 'terms_of_service', to: 'stractic_pages#terms_of_service'
  resources :users
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # Defines the root path route ("/")
  # root "posts#index"
end
