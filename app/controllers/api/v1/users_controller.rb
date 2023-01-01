module Api
  module V1
    class UsersController < ApplicationController
      def create
        p "hey"
        user = User.new(user_params)
        if user.save!
          render json: { user: }, status: :ok
        else
          render status: :not_acceptable
        end
      end

      def index
        p "yes"
      end

      private

      def user_params
        params.require(:user).permit(:uid, :name)
      end
    end
  end
end
