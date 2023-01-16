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
      end
    end
  end
end
