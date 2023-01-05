module Api
  module V1
    module Users
      class UsersController < ApplicationController
        require "jwt"

        def create
          decoded_token = JWT.decode(user_params[:access_token], nil, false)
          user_info = decoded_token[0]
          name, email, user_id = user_info.values_at("name", "email", "user_id")
          user = User.new(name:, uid: user_id, email:)
          if user.save!
            render json: user, status: :ok
          else
            render json: {}, status: :not_acceptable
          end
        end

        def index
          p "yes"
        end

        private

        def user_params
          params.require(:user).permit(:uid, :name, :access_token)
        end
      end
    end
  end
end
