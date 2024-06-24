Rails.application.routes.draw do
  get 'recipes/new'
  get 'goals/new'
  get 'goals/create'
  get 'goals/show'
  get 'goals/update'
  get 'goals/edit'
  root "stractic_pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  get 'terms_of_service', to: 'stractic_pages#terms_of_service'
  resources :users do 
    resources :bodies do
      resources :goals 
    end
  end
  resources :recipes, only: %i[new create update show]
  get '/recipes/result', to: 'recipes#result', as: 'recipes_result'
  get '/recipes/chat', to: 'recipes#chat', as: 'recipes_chat'
  get '/recipes/details', to: 'recipes#details', as: 'recipes_details'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
