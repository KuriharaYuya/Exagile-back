Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users, path: "/" do
        post "/signup", to: "users#create"
      end
      namespace :appoints, path: "/" do
        resources :appoints
      end
      namespace :characters, path: "/" do
        resources :characters
      end
      namespace :appoint_characters, path: "/" do
        resources :appoint_characters do
          collection do
            get :characters
            get :appoints
            delete :destroy
          end
        end
      end
      get "/sessions/check", to: "auth/sessions#check"
      post "/login", to: "auth/sessions#create"
      delete "/logout", to: "auth/sessions#destroy"
    end
  end
end
