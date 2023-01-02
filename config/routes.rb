Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
      post "/signup", to: "users#create"
    end
  end
end
