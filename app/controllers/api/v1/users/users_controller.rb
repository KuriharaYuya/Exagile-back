module Api
  module V1
    module Users
      class UsersController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user, only: :options
        require "jwt"

        def create
          decoded_token = JWT.decode(user_params[:access_token], nil, false)
          user_info = decoded_token[0]
          name, email, user_id = user_info.values_at("name", "email", "user_id")
          name ||= user_params[:username]
          user = User.new(name:, uid: user_id, email:)
          if user.save!
            render json: user, status: :ok
          else
            render json: {}, status: :not_acceptable
          end
        end

        def options
          options = current_user.manipulate_options
          render json: { options: }, status: :ok
        end

        def update_options
          options = user_params[:options]
          current_user.update(manipulate_options: options)
          current_user.save
          render json: { options: }, status: :ok
        end

        private

        def user_params
          params.require(:user).permit(:access_token, :username, options: [faqs: [sort: [:tags, :created_at], filter: [:tags, :created_at]]])
        end
      end
    end
  end
end
