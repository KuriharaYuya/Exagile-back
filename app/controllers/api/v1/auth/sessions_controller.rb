module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        include SessionHelper
        def create
          decoded_token = JWT.decode(session_params[:access_token], nil, false)
          user_info = decoded_token[0]
          user_id = user_info.values_at("user_id")
          user = User.find_by(uid: user_id)
          return if user.nil?

          session[:user_id] = user.uid
          cookies["user_id"] = {
            value: user.uid,
            max_age: 3600 * 24 * 7, # 寿命は7日間
            httponly: true, # JavaScriptからのアクセスを禁止,
            secure: true,
          }
          cookies["isLoggedIn"] = {
            value: true,
            max_age: 3600 * 24 * 7,
            httponly: false,
            secure: true,
          }
          render json: { user: }, status: :ok
        end

        def check
          return if session[:user_id] != cookies[:user_id] || cookies[:user_id].nil?

          cookies["isLoggedIn"] = {
            value: true,
            max_age: 3600 * 24 * 7,
            httponly: false,
            secure: true,
          }
          if logged_in?
            render json: { isLoggedIn: logged_in?, currentUser: current_user }, status: :ok
          end
        end

        def destroy
          reset_session
          cookies.delete(:user_id, max_age: 0)
          cookies.delete(:isLoggedIn, max_age: 0)
          render json: {}, status: :ok
        end

        private

        def session_params
          params.require(:session).permit(:access_token)
        end
      end
    end
  end
end
