Rails.application.routes.draw do
  get 'stractic_pages/top'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "stractic_pages#top"
  get 'terms_of_service', to: 'stractic_pages#terms_of_service'

  # Defines the root path route ("/")
  # root "posts#index"
end
