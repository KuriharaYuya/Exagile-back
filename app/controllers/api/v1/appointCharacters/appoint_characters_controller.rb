module Api
  module V1
    module AppointCharacters
      class AppointCharactersController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        # createとdestroyには認証が必要
        before_action :authenticate_user, only: %i[create destroy]
        def create
          appoint = Appoint.find(params[:appoint_id])
          character = Character.find(params[:character_id])
          appoint.characters << character
          render json: { character: }, status: :ok
        end

        def characters
          appoint = Appoint.find(params[:appoint_id])
          characters = appoint.characters
          render json: { characters: }, status: :ok
        end

        def destroy
          appoint_id = params[:appoint_id]
          character_id = params[:character_id]
          relation = AppointCharacter.find_by(appoint_id:, character_id:)
          if relation.destroy!
            render json: {}, status: :ok
          else
            render json: {}, status: :internal_server_error
          end
        end
      end
    end
  end
end
