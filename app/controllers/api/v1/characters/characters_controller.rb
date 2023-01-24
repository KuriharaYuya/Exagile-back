module Api
  module V1
    module Characters
      class CharactersController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user

        def index
          tgt_word = @arams[:characters][:tgtWord]
          appoint_id = params[:characters][:appoint_id]
          appoint = Appoint.find(appoint_id)
          appoint_characters_ids = appoint.characters.pluck(:id)
          characters = current_user.characters.where.not(id: appoint_characters_ids)
          characters = if tgt_word.blank?
                         characters.order("updated_at DESC").limit(25)
                       else
                         characters.where("name LIKE ?", "#{tgt_word}%").limit(25)
                       end
          render json: characters, status: :ok
        end

        def communities_suggestion
          character_id = params[:id]
          character = Character.find(character_id)
          boud_communities_ids = character.communities.pluck(:id)
          communities = current_user.communities.where.not(id: boud_communities_ids)
          render json: { communities: }, status: :ok
        end

        def unregister_community
          character_id, community_id = params[:character].values_at("character_id", "community_id")
          character = Character.find(character_id)
          return unless character.user.id == current_user.id

          relation = CharactersCommunity.find_by(character_id:, community_id:)
          render json: {}, status: :ok if relation.destroy
        end

        def details
          appoint_id = params[:appoint_id]
          character = Character.find(params[:character_id])
          topics = Topic.bound_topics(appoint_id, character.id)
          render json: { character:, topics: }, status: :ok
        end

        def show
          character = Character.find(params[:id])
          topics = character.topics
          communities = character.communities
          render json: { character:, topics:, communities: }, status: :ok
        end

        def create
          appoint_id, keyword = params[:character].values_at("appoint_id", "keyword")
          return if appoint_id.nil?

          character = current_user.characters.build(name: keyword)
          character_id = character.id if character.save
          relation = AppointCharacter.new(character_id:, appoint_id:)
          relation.save
          render json: { character: }, status: :ok
        end

        def update
          data = params[:character]
          name, profile, character_id = data.values_at("name", "profile", "id")
          character = Character.find(character_id)
          character.update(name:, profile:)
          character.save
          render json: {}, status: :ok
        end

        def destroy
          character = Character.find(params[:id])
          render json: {}, status: :ok if character.destroy!
        end
      end
    end
  end
end
