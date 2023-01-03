Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
      namespace :users, path: "/" do
        post "/signup", to: "users#create"
      end
      get "/sessions/check", to: "auth/sessions#check"
      post "/login", to: "auth/sessions#create"
      delete "/logout", to: "auth/sessions#destroy"
    end
  end
end
