module Api
  module V1
    module Characters
      class CharactersController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user

        def index
          tgt_word = params[:characters][:tgtWord]
          characters = if tgt_word.blank?
                         current_user.characters.order("updated_at DESC").limit(25)
                       else
                         current_user.characters.where("name LIKE ?", "#{tgt_word}%").limit(25)
                       end
          render json: characters, status: :ok
        end

        def details
          appoint_id = params[:appoint_id]
          character = Character.find(params[:character_id])
          topics = Topic.bound_topics(appoint_id, character.id)
          render json: { character:, topics: }, status: :ok
        end

        def show
          character = Character.find(params[:id])
          render json: { character: }, status: :ok
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
