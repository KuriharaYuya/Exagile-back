module Api
  module V1
    module Appoints
      class AppointsController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user

        def index
          start_date = params[:start]
          end_date = params[:end]
          appoints =  appoints_list(start_date, end_date)
          render json: appoints, status: :ok
        end

        def show
          appoint = return_appoint
          inspired_faqs = appoint.inspired_faqs.sort_by(&:updated_at).reverse
          applied_faqs = appoint.applied_faqs.sort_by(&:updated_at).reverse
          faqs = {
            inspiredFaqs: inspired_faqs,
            appliedFaqs: applied_faqs
          }
          insight = appoint.insights.sort_by(&:created_at).reverse
          render json: { appoints: { appoint:, faqs:, insight: } }, status: :ok
        end

        def update
          appoint = return_appoint
          appoint.update(appoint_params)
          if appoint.save!
            render json: appoint, status: :ok
          end
        end

        def create
          appoint = current_user.appoints.build(appoint_params)
          appoint.save
          render json: appoint, status: :ok
        end

        def destroy
          appoint = return_appoint
          render json: {}, status: :ok if appoint.destroy!
        end

        private

        def return_appoint
          id = appoint_params[:id]
          Appoint.find(id)
        end

        def appoints_list(start_date, end_date)
          return if current_user.nil? || current_user.appoints.nil?

          current_user.appoints.between_dates(start_date, end_date).order(start: :asc)
        end

        def appoint_params
          params.require(:appoints).permit(:user_id, :id, :title, :start, :end, :desc, :content)
        end
      end
    end
  end
end
