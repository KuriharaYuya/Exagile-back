module Api
  module V1
    module AppointCharacters
      class AppointCharactersController < ApplicationController
        def create
          appoint = Appoint.find(params[:appoint_id])
          character = Character.find(params[:character_id])
          appoint.characters << character
          p appoint.characters
          render json: { character: }, status: :ok
        end

        def characters
          appoint = Appoint.find(params[:appoint_id])
          characters = appoint.characters
          render json: { characters: }, status: :ok
        end

        def appoints
          p "appooints"
        end
      end
    end
  end
end
