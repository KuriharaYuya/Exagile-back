module Api
  module V1
    module Communities
      class CommunitiesController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        include CharactersCommunitiesHelper
        before_action :authenticate_user
        def index
          communities = current_user.communities.sort_by(&:name)
          render json: { communities: }, status: :ok
        end

        def show
          community_id = params[:id]
          community = Community.find(community_id)
          characters_communities = return_characters_communities(community_id)
          data = {
            community:,
            characters: characters_communities
          }
          render json: data
        end

        def destroy
          community_id = params[:id]
          community = Community.find(community_id)
          render json: {}, status: :ok if community.destroy
        end

        def update
          community_id = params[:id]
          name = params[:name]
          community = Community.find(community_id)
          community.update(name:)
          community.save
          render json: {}, status: :ok
        end

        def create
          name = params[:community][:name]
          community = current_user.communities.build(name:)
          render json: { community: }, status: :ok if community.save
        end
      end
    end
  end
end
