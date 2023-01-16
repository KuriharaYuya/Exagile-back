module Api
  module V1
    module Topics
      class TopicsController < ApplicationController
        include ::Api::V1::Auth::SessionHelper

        def update
          p "hey"
          topic = Topic.find(params[:id])
          topic.update(topic_params)
          topic.save
          p topic.title
        end

        def create
          appoint_id, character_id = params[:topic].values_at("appoint_id", "character_id")
          topic = current_user.topics.build(appoint_id:, character_id:, title: "Untitiled")
          topic.save
          render json: topic, status: :ok
        end

        def destroy
          topic = Topic.find(params[:id])
          render json: {}, status: :ok if topic.destroy
        end

        private

        def topic_params
          params.require(:topics).permit(:title, :content)
        end
      end
    end
  end
end
