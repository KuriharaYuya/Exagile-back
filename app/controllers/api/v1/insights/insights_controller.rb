module Api
  module V1
    module Insights
      class InsightsController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user

        def update
          id, title, content, archived, concerning = params[:insight].values_at("id", "title", "content", "archived", "concerning")
          insight = Insight.find(id)
          reutrn unless insight.user.uid == current_user.uid

          insight.update(title:, content:, archived:, concerning:)
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

        def reviews
          options = current_user.manipulate_options["insights"]
          length = current_user.insights.length
          per_page_row = 25
          data_qty = params[:data_qty].to_i + per_page_row > length ? length : params[:data_qty].to_i + per_page_row
          insights = current_user.insights.where(archived: false).order(reviewed_at: options["sort"]["reviewed_at"]).offset(0).limit(data_qty)
          render json: { insights:, length: }, status: :ok
        end

        def concerns
          concerns = current_user.insights.where(concerning: true)
          render json: { concerns: }, status: :ok
        end

        def archives
          insights = current_user.insights.where(archived: true)
          length = insights.length
          render json: { insights:, length: }, status: :ok
        end
      end
    end
  end
end
