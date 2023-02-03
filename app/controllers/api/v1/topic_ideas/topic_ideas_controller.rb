module Api
  module V1
    module TopicIdeas
      class TopicIdeasController < ApplicationController
        include ::Api::V1::Auth::SessionHelper

        def index
          character_id, data_qty = params[:topic_ideas].values_at("character_id", "data_qty")
          character = Character.find(character_id)
          ideas = character.topic_ideas.order(created_at: "desc")
          length = ideas.length
          data_qty = data_qty.to_i
          data_qty = data_qty > length ? data_qty - 1 : data_qty
          ideas = ideas.offset(0).limit(data_qty + 5)
          render json: { ideas:, length: }, status: :ok
        end

        def create
          character_id, title, content, done, idea_type = params[:topic_ideas].values_at("character_id", "title", "content", "done", "idea_type")
          character = Character.find(character_id)
          return unless character.user.uid == current_user.uid

          idea = character.topic_ideas.build(title:, content:, done:, user_id: current_user.uid, idea_type:)
          idea.save!
          length = character.topic_ideas.length
          render json: { idea:, length: }, status: :ok
        end

        def update
          title, content, done, id, idea_type = params[:topic_ideas].values_at("title", "content", "done", "id", "idea_type")
          idea = TopicIdea.find(id)
          idea.update(title:, content:, done:, idea_type:)
          render json: { idea: }, status: :ok if idea.save
        end
      end
    end
  end
end
