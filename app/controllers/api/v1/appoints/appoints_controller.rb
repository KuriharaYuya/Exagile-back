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

        private

        def appoints_list(start_date, end_date)
          return if current_user.appoints.nil?

          current_user.appoints.between_dates(start_date, end_date).order(start: :asc)
        end
      end
    end
  end
end
