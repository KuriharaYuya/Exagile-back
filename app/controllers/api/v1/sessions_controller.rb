module Api
  module V1
    class SessionsController < ApplicationController
      def create
        decoded_token = JWT.decode(session_params[:access_token], nil, false)
        render json: { decoded_token: }, status: :ok
      end

      private

      def session_params
        params.require(:session).permit(:access_token)
      end
    end
  end
end
