Rails.application.routes.draw do
  get 'bookmark/create'
  get 'bookmark/destroy'
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

  resources :recipes, only: %i[new create update show] do
    collection do
      get :bookmarks
    end
    resources :bookmarks, only: %i[create destroy], shallow: true
  end
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
