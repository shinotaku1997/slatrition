Rails.application.routes.draw do
  get 'goals/new'
  get 'goals/create'
  get 'goals/show'
  get 'goals/update'
  get 'goals/edit'
root "stractic_pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  get 'terms_of_service', to: 'stractic_pages#terms_of_service'
  resources :users do 
    resources :bodies 
    resources :goals
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # Defines the root path route ("/")
  # root "posts#index"
end
