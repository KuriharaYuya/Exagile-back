module Api
  module V1
    module Insights
      class InsightsController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user

        def update
          id, title, content = params[:insight].values_at("id","title", "content")
          insight = Insight.find(id)
          reutrn unless insight.user.uid == current_user.uid

          insight.update(title:, content:)
          render json: { insight: }, status: :ok if insight.save
        end

        def create
          appoint = Appoint.find(params[:insight][:id])
          return unless appoint.user.uid == current_user.uid

          insight = appoint.insights.build(title: "Untitled", user_id: current_user.uid)
          render json: { insight: }, status: :ok if appoint.save
        end

        def destroy
          insight = Insight.find(params[:id])
          return unless insight.user.uid == current_user.uid

          render json: {}, status: :ok if insight.destroy
        end
      end
    end
  end
end
