module Api
  module V1
    module CharactersCommunities
      class CharactersCommunitiesController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user
        def create
          character_id, community_id = params[:character_communities].values_at("character_id", "community_id")
          relation = CharactersCommunity.new(character_id:, community_id:)
          render json: {}, status: :ok if relation.save
        end
      end
    end
  end
end
