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
        get "characters/details", to: "characters#details"
        get "characters/characters_communities", to: "characters#characters_communities"
        resources :characters do
          # memberは、特定のid用、collectionは一覧取得用
          collection do
            post :unregister_community
          end
          member do
            get :communities_suggestion
          end
        end
      end
      namespace :characters_communities, path: "/" do
        resources :characters_communities
      end
      namespace :faqs, path: "/" do
        resources :faqs
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
      namespace :topics, path: "/" do
        resources :topics
      end
      namespace :communities, path: "/" do
        resources :communities
      end
      get "/sessions/check", to: "auth/sessions#check"
      post "/login", to: "auth/sessions#create"
      delete "/logout", to: "auth/sessions#destroy"
    end
  end
end
