module Api
  module V1
    module Auth
      module SessionHelper
        def logged_in?
          !!session[:user_id]
        end

        def current_user
          @current_user ||= User.find_by(uid: session[:user_id])
        end

        def authenticate_user
          if session[:user_id] != cookies[:user_id]
            render json: { message: "Unauthorized" }, status: :unauthorized
          end
        end
      end
    end
  end
end
