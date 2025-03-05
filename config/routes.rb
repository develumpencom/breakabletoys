Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :applications do
    resources :oauth_application_credentials, only: [ :create, :destroy ], shallow: true, path: "oauth-application-credentials"
  end
  resource :account, only: [ :show ], module: "users"
  resource :newsletter, only: [ :create, :update, :destroy ], controller: "newsletter"
  resources :toys
  resources :passwords, param: :token
  resource :session

  get "/oauth/auth", to: "oauth#auth"
  post "/oauth/token", to: "oauth#token"

  get "/sign-up", to: "users/registrations#new"
  post "/sign-up", to: "users/registrations#create"

  root "home#show"
end
