module Api
  module V1
    module Topics
      class TopicsController < ApplicationController
        include ::Api::V1::Auth::SessionHelper

        def update
          topic = Topic.find(params[:id])
          topic.update(topic_params)
          topic.save
          render json: topic, status: :ok
        end

        def create
          appoint_id, character_id = params[:topic].values_at("appoint_id", "character_id")
          topic = if !appoint_id.nil?
                    current_user.topics.build(appoint_id:, character_id:, title: "Untitiled")
                  else
                    current_user.topics.build(character_id:, title: "Untitiled")
                  end
          topic.save
          render json: topic, status: :ok
        end

        def destroy
          topic = Topic.find(params[:id])
          render json: {}, status: :ok if topic.destroy
        end

        def index
          character_id = params[:character_id]
          topics = Topic.joins(:appoint)
                          .select("topics.*,
                            appoints.id as appointId,
                              appoints.title as appointTitle,
                                appoints.start as appointStart")
                                  .where(character_id:)
          render json: { topics: }, status: :ok
        end

        private

        def topic_params
          params.require(:topics).permit(:title, :content)
        end
      end
    end
  end
end
